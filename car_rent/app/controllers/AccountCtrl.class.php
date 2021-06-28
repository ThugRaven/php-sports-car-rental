<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\forms\AccountEditForm;
use core\DBUtils;

class AccountCtrl {

    private $form;
    private $records;
    private $rents;

    public function __construct() {
        $this->form = new AccountEditForm();
    }

    public function validate() {
        $this->form->login = ParamUtils::getFromCleanURL(1);

        if (!(isset($this->form->login))) {
            return false;
        }
        if ($this->form->login !== (SessionUtils::loadObject('user', true)->login)) {
            Utils::addErrorMessage('Brak dostępu');
            return false;
        }

        $this->records = DBUtils::get('user', [
                    '[><]user_role' => 'id_user_role'
                        ], [
                    'user.login',
                    'user.email',
                    'user_role.role_name',
                    'user.name',
                    'user.surname',
                    'user.phone_number',
                    'user.rents',
                    'user.verified',
                    'user.birth_date'
                        ], [
                    'login' => $this->form->login
        ]);

        $id_user = DBUtils::get('user', null, 'id_user', [
                    'login' => SessionUtils::loadObject('user', true)->login]
        );

        $where['id_user'] = $id_user;
        $where['ORDER'] = ['create_time' => 'DESC'];
        $this->rents = DBUtils::select('rent', [
                    '[><]rent_status' => 'id_rent_status',
                    '[><]car' => 'id_car',
                        ], '*', $where);
        for ($i = 0; $i < count($this->rents); $i++) {
            $this->rents[$i]['brand_url'] = trim($this->rents[$i]['brand']);
            $this->rents[$i]['model_url'] = trim($this->rents[$i]['model']);
            $this->rents[$i]['brand_url'] = strtolower($this->rents[$i]['brand_url']);
            $this->rents[$i]['model_url'] = strtolower($this->rents[$i]['model_url']);
            $this->rents[$i]['brand_url'] = preg_replace('/\s+/', '-', $this->rents[$i]['brand_url']);
            $this->rents[$i]['model_url'] = preg_replace('/\s+/', '-', $this->rents[$i]['model_url']);
        }

        App::getSmarty()->assign('page_title', "Moje Konto");
        return !App::getMessages()->isError();
    }

    public function action_account() {
        $this->validate();
        App::getSmarty()->assign('account', $this->records);
        App::getSmarty()->assign('rents', $this->rents);
        $this->generateView();
    }

    public function action_accountEdit() {
        $this->form->login_old = ParamUtils::getFromCleanURL(1);

        if (!(isset($this->form->login_old))) {
            return false;
        }
        if ($this->form->login_old !== (SessionUtils::loadObject('user', true)->login)) {
            Utils::addErrorMessage('Brak dostępu');
            return false;
        }

        $this->records = DBUtils::get('user', null, [
                    'login',
                    'email',
                    'name',
                    'surname',
                    'phone_number',
                    'birth_date'
                        ], [
                    'login' => $this->form->login_old
        ]);

        $this->form->login = $this->records['login'];
        $this->form->email = $this->records['email'];
        $this->form->name = $this->records['name'];
        $this->form->surname = $this->records['surname'];
        $this->form->phone_number = $this->records['phone_number'];
        $this->form->birth_date = $this->records['birth_date'];

        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
        App::getSmarty()->assign('page_title', "Moje Konto - Ustawienia");

        App::getSmarty()->display('AccountEditView.tpl');
    }

    public function action_accountSave() {
        $this->form->login_old = ParamUtils::getFromRequest('login_old');
        $this->form->login = ParamUtils::getFromRequest('login');
        $this->form->password = ParamUtils::getFromRequest('password');
        $this->form->email = ParamUtils::getFromRequest('email');
        $this->form->name = ParamUtils::getFromRequest('name');
        $this->form->surname = ParamUtils::getFromRequest('surname');
        $this->form->phone_number = ParamUtils::getFromRequest('phone_number');
        $this->form->birth_date = ParamUtils::getFromRequest('birth_date');

        print_r($this->form);

        if (!(isset($this->form->login_old))) {
            Utils::addErrorMessage('Brak dostępu');
            SessionUtils::storeMessages();
            App::getRouter()->redirectTo('main');
            return false;
        }
        if ($this->form->login_old !== (SessionUtils::loadObject('user', true)->login)) {
            Utils::addErrorMessage('Brak dostępu');
            SessionUtils::storeMessages();
            App::getRouter()->redirectTo('main');
            return false;
        }

        $form_old = DBUtils::get('user', null, [
                    'login',
                    'password',
                    'email',
                    'name',
                    'surname',
                    'phone_number',
                    'birth_date'], [
                    'login' => $this->form->login_old
        ]);

        $column_params = [];
        print_r($form_old);
        echo "<pre>";
        foreach ($form_old as $key => $value) {
            $form_value = $this->form->$key;
            echo "value: $value, key: $key, form: " . $form_value . "\n";
            if ($key === 'password') {
                continue;
            }
            if ($value != $form_value && isset($form_value) && !empty($form_value)) {
                echo "$value is different, key: $key\n";
                $column_params[$key] = $form_value;
            }
        }
        echo "</pre>";

        if (!password_verify($this->form->password, $form_old['password']) && isset($this->form->password) && !empty($this->form->password)) {
            echo 'passwords are different' . "\n";
            $column_params['password'] = password_hash($this->form->password, PASSWORD_BCRYPT);
        }

        $columns = &$column_params;

        print_r($columns);

        if ($this->form->login === $form_old['login']) {
            $isAvailable = true;
        } else {
            $isAvailable = !(DBUtils::has('user', null, [
                        'login' => $this->form->login
            ]));
        }

        if (!$isAvailable) {
            Utils::addErrorMessage('Podany login jest już zajęty');
        }
        if (count($columns) < 1) {
            Utils::addInfoMessage('Brak zmian');
        } else {
            if (!App::getMessages()->isError()) {
                DBUtils::update('user', $columns, [
                    'login' => $this->form->login_old
                ]);
                Utils::addInfoMessage('Zapisano!');

                $user = SessionUtils::loadObject('user', true);
                $user->login = $this->form->login;
                SessionUtils::storeObject('user', $user);
            }
        }

        SessionUtils::storeMessages();

        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));

        App::getRouter()->redirectTo('account/' . SessionUtils::loadObject('user', true)->login);
    }

//    public function action_accountDelete() {
//        $this->form->login = ParamUtils::getFromCleanURL(1);
//        print_r($this->form->login);
//
//        if (!(isset($this->form->login))) {
//            return false;
//        }
//        if ($this->form->login !== (SessionUtils::loadObject('user', true)->login)) {
//            Utils::addErrorMessage('Brak dostępu');
//            return false;
//        }
//
////        DBUtils::delete('user', [
////            'login' => $this->form->login
////        ]);
//        App::getDB()->delete('user', [
//            'login' => $this->form->login
//        ]);
//        Utils::addInfoMessage('Pomyślnie usunięto konto!');
//
////        App::getRouter()->redirectTo('main');
//    }

    public function generateView() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('records', $this->records);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));

        App::getSmarty()->display('AccountView.tpl');
    }

}
