<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use app\transfer\User;
use app\forms\LoginForm;

class LoginCtrl {

    private $form;

    public function __construct() {
        $this->form = new LoginForm();
    }

    public function getParams() {
        $this->form->login = ParamUtils::getFromRequest('login');
        $this->form->pwd = ParamUtils::getFromRequest('pwd');
    }

    public function validate() {
        if (!(isset($this->form->login) && isset($this->form->pwd))) {
            return false;
        }

        if (!App::getMessages()->isError()) {
            if ($this->form->login == "") {
                Utils::addErrorMessage('Nie podano loginu');
            }
            if ($this->form->pwd == "") {
                Utils::addErrorMessage('Nie podano hasła');
            }
        }

        if (!App::getMessages()->isError()) {
            try {
                $hashed_pwd = App::getDB()->get("user", "password", [
                    "login" => $this->form->login
                ]);
            } catch (PDOException $ex) {
                getMessages()->addError('Wystąpił błąd podczas pobierania rekordów');
            }

            if (password_verify($this->form->pwd, $hashed_pwd)) {
                //TODO: Get here all the user info and put it in session

                $role = App::getDB()->get("user", [
                    "[><]user_role" => "id_user_role"
                        ], "user_role.name", [
                    "login" => $this->form->login
                ]);

                print_r($role);

                $user = new User($this->form->login, $role);
                //TODO: Change to SessionUtils
                $_SESSION['user'] = serialize($user);
                RoleUtils::addRole($role);
            } else {
                Utils::addErrorMessage("Niepoprawny login lub hasło!");
            }
        }

        return !App::getMessages()->isError();
    }

    public function action_login() {
        $this->getParams();

        if ($this->validate()) {
            App::getRouter()->redirectTo("main");
        } else {
            $this->generateView();
        }
    }

    public function action_logout() {
        session_unset();
        session_destroy();

        Utils::addInfoMessage('Poprawnie wylogowano z systemu');

        $this->generateView();
    }

    public function generateView() {
        App::getSmarty()->assign('form', $this->form);
        if (isset($_SESSION['user'])) {
            App::getSmarty()->assign('user', unserialize($_SESSION['user']));
        } else {
            App::getSmarty()->assign('user', null);
        }

        App::getSmarty()->display("LoginView.tpl");
    }

}
