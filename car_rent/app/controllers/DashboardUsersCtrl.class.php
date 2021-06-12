<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\transfer\User;
use app\forms\UserForm;
use app\forms\UserEditForm;
use core\Validator;
use core\DBUtils;

class DashboardUsersCtrl {

    private $form;
    private $records;
    private $search_params;
    private $orders;
    private $inputs;
    private $v;

    public function __construct() {
        $this->form = new UserForm();
        $this->form_edit = new UserEditForm();
        $this->search_params = [];
        $this->orders = [
            array('', 'Alfabetycznie'),
            array('user.id_user-desc', 'ID malejąco'),
            array('user.id_user-asc', 'ID rosnąco'),
            array('user.rents-desc', 'Liczba wypożyczeń malejąco'),
            array('user.rents-asc', 'Liczba wypożyczeń rosnąco')
        ];
        $this->inputs = [
            'id_user' => ['ID Użytkownika', false],
            'id_user_role' => ['ID Roli', false],
            'login' => ['Login', false],
            'password' => ['Hasło', false],
            'email' => ['Email', false],
            'name' => ['Imię', false],
            'surname' => ['Nazwisko', false],
            'phone_number' => ['Numer telefonu', false],
            'rents' => ['Liczba wypożyczeń', false],
            'verified' => ['Zweryfikowany', false],
            'birth_date' => ['Data urodzenia', false],
            'create_time' => ['Data utworzenia konta', false],
            'role_name' => ['Rola', false],
        ];
        $this->v = new Validator();
    }

    public function processDashUsers() {
        $this->form->login = ParamUtils::getFromRequest('login');
        $this->form->order = ParamUtils::getFromRequest('order');
        $this->form->verified = ParamUtils::getFromRequest('verified');
        $this->form->role_name = ParamUtils::getFromRequest('role_name');

        $roles = DBUtils::select('user_role', null, 'role_name');

        print_r($roles);
        print_r($this->form->role_name);
        App::getSmarty()->assign('roles', $roles);
        App::getSmarty()->assign('orders', $this->orders);

        $this->search_params = DBUtils::prepareParam($this->form->login, 'login[~]', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->verified, 'verified', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->role_name, 'role_name', $this->search_params);

        $where = DBUtils::prepareWhere($this->search_params, $this->form->order, 'id_user');

        $this->records = DBUtils::select('user', [
                    '[><]user_role' => 'id_user_role'
                        ], [
                    'user.id_user',
                    'user.login',
                    'user.name',
                    'user.surname',
                    'user.phone_number',
                    'user.rents',
                    'user.verified',
                    'user.create_time',
                    'user_role.role_name'
                        ], $where);

        App::getSmarty()->assign('form', $this->form);
        $this->assignSmarty();
        return !App::getMessages()->isError();
    }

    public function processDashUserEdit() {
        $this->form_edit->id_user = $this->v->validateFromCleanURL(1, [
            'trim' => true,
            'required' => true,
            'required_message' => 'ID użytkownika jest wymagane',
            'int' => true,
            'validator_message' => 'ID użytkownika musi być liczbą całkowitą'
        ]);

        $isValid = DBUtils::has('user', null, [
                    'id_user' => $this->form_edit->id_user
        ]);
        if (!$isValid) {
            Utils::addErrorMessage('Brak podanego użytkownika');
            return false;
        }

        $this->user = DBUtils::get('user', [
                    '[><]user_role' => 'id_user_role'
                        ], [
                    'user.id_user',
                    'user.id_user_role',
                    'user.login',
                    'user.email',
                    'user.name',
                    'user.surname',
                    'user.phone_number',
                    'user.rents',
                    'user.verified',
                    'user.birth_date',
                    'user_role.role_name'
                        ], [
                    'id_user' => $this->form_edit->id_user
        ]);
        print_r($this->user);

        $roles = DBUtils::select('user_role', null, 'role_name');

        App::getSmarty()->assign('roles', $roles);
        App::getSmarty()->assign('inputs', $this->inputs);
        App::getSmarty()->assign('users', $this->user);
        print_r($this->inputs);
        $this->assignSmarty();
        return !App::getMessages()->isError();
    }

    public function processDashUserSave() {
        $this->form_edit->id_user = ParamUtils::getFromRequest('id_user');
        $this->form_edit->id_user_role = ParamUtils::getFromRequest('id_user_role');
        $this->form_edit->login = ParamUtils::getFromRequest('login');
        $this->form_edit->email = ParamUtils::getFromRequest('email');
        $this->form_edit->name = ParamUtils::getFromRequest('name');
        $this->form_edit->surname = ParamUtils::getFromRequest('surname');
        $this->form_edit->phone_number = ParamUtils::getFromRequest('phone_number');
        $this->form_edit->rents = ParamUtils::getFromRequest('rents');
        $this->form_edit->verified = ParamUtils::getFromRequest('verified');
        $this->form_edit->birth_date = ParamUtils::getFromRequest('birth_date');
        $this->form_edit->role_name = ParamUtils::getFromRequest('role_name');

        print_r($this->form_edit);

        $isValid = DBUtils::has('user', null, [
                    'id_user' => $this->form_edit->id_user
        ]);
        if (!$isValid) {
            Utils::addErrorMessage('Brak podanego użytkownika');
            return false;
        }

        $user_old = DBUtils::get('user', [
                    '[><]user_role' => 'id_user_role'
                        ], [
                    'user.id_user',
                    'user.id_user_role',
                    'user.login',
                    'user.email',
                    'user.name',
                    'user.surname',
                    'user.phone_number',
                    'user.rents',
                    'user.verified',
                    'user.birth_date',
                    'user_role.role_name'
                        ], [
                    'id_user' => $this->form_edit->id_user
        ]);

        $this->form_edit->verified = DBUtils::getCheckbox($this->form_edit->verified);

        $column_params = [];
        print_r($user_old);
        echo "<pre>";
        foreach ($user_old as $key => $value) {
            $form_value = $this->form_edit->$key;
            echo "value: $value, key: $key, form: " . $form_value . "\n";
            if ($value != $form_value && $key === 'verified' || $key === 'rents') {
                echo "1 $value is different, key: $key\n";
                $column_params[$key] = $form_value;
            } else if ($value != $form_value && $this->inputs[$key][1]) {
                echo "2 $value is different, key: $key\n";
                $column_params[$key] = $form_value;
            } else if ($value != $form_value && isset($form_value) && !empty($form_value)) {
                echo "3 $value is different, key: $key\n";
                $column_params[$key] = $form_value;
            }
        }
        echo "</pre>";

        $columns = &$column_params;

        print_r($columns);

        if (count($columns) < 1) {
            Utils::addInfoMessage('Brak zmian');
        } else {
            if (!App::getMessages()->isError()) {
                if (isset($columns['role_name'])) {
                    $user_role = DBUtils::get('user_role', null, 'id_user_role', [
                                'role_name' => $columns['role_name']
                    ]);

                    DBUtils::update('user', [
                        'id_user_role' => $user_role
                            ], [
                        'id_user' => $this->form_edit->id_user
                    ], true);

                    unset($columns['role_name']);
                }
                print_r($columns);

                if (count($columns) > 0) {
                    DBUtils::update('user', $columns, [
                        'id_user' => $this->form_edit->id_user
                    ], true);
                }

                Utils::addInfoMessage('Zapisano!');
            }
        }

        SessionUtils::storeMessages();

        $this->assignSmarty();
        return !App::getMessages()->isError();
    }

    public function action_dashboardUsers() {
        if ($this->processDashUsers()) {
            App::getSmarty()->display('DashboardUsersView.tpl');
        } else {
            App::getRouter()->redirectTo('dashboard');
        }
    }

    public function action_dashboardUserEdit() {
        if ($this->processDashUserEdit()) {
            App::getSmarty()->display('DashboardUserEditView.tpl');
        } else {
            App::getRouter()->redirectTo('dashboardUsers');
        }
    }

    public function action_dashboardUserSave() {
        if ($this->processDashUserSave()) {
//            App::getRouter()->redirectTo('dashboardUsers');
        } else {
//            App::getRouter()->redirectTo('dashboardUsers');
        }
    }

    public function assignSmarty() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
        App::getSmarty()->assign('records', $this->records);
    }

}
