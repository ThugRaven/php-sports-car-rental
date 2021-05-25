<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\forms\AccountEditForm;

class AccountCtrl {

    private $form;
    private $records;

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

        try {
            $this->records = App::getDB()->get('user', [
                '[><]user_role' => 'id_user_role'
                    ], [
                'user.login',
                'user.email',
                'user_role.name(role_name)',
                'user.name',
                'user.surname',
                'user.phone_number',
                'user.rents',
                'user.verified',
                'user.birth_date'
                    ], [
                'login' => $this->form->login
            ]);
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        return !App::getMessages()->isError();
    }

    public function action_account() {
        $this->validate();
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

        try {
            $this->records = App::getDB()->get('user', [
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
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));

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

        try {
            $form_old = App::getDB()->get('user', [
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
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        try {
            if ($this->form->login === $form_old['login']) {
                $isAvailable = true;
            } else {
                $isAvailable = !(App::getDB()->has('user', [
                            'login' => $this->form->login
                ]));
            }
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }
        if (!$isAvailable) {
            Utils::addErrorMessage('Podany login jest już zajęty');
        }
        if (count($columns) < 1) {
            Utils::addInfoMessage('Brak zmian');
        }
        if (!App::getMessages()->isError()) {
            try {
                print_r(App::getDB()->update('user', $columns, [
                            'login' => $this->form->login_old
                ]));
                Utils::addInfoMessage('Zapisano!');

                $user = SessionUtils::loadObject('user', true);
                $user->login = $this->form->login;
                SessionUtils::storeObject('user', $user);
            } catch (PDOException $ex) {
                Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
                if (App::getConf()->debug) {
                    Utils::addErrorMessage($ex->getMessage());
                }
            }
        }

        SessionUtils::storeMessages();

        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));

        App::getRouter()->redirectTo('main');
    }

    public function generateView() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('records', $this->records);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));

        App::getSmarty()->display('AccountView.tpl');
    }

}
