<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\transfer\User;
use app\forms\RegisterForm;

class RegisterCtrl {

    private $form;

    public function __construct() {
        $this->form = new RegisterForm();
    }

    public function getParams() {
        $this->form->login = ParamUtils::getFromRequest('login');
        $this->form->password = ParamUtils::getFromRequest('password');
        $this->form->email = ParamUtils::getFromRequest('email');
        $this->form->name = ParamUtils::getFromRequest('name');
        $this->form->surname = ParamUtils::getFromRequest('surname');
        $this->form->phone_number = ParamUtils::getFromRequest('phone_number');
        $this->form->birth_date = ParamUtils::getFromRequest('birth_date');
    }

    public function validate() {
        foreach ($this->form as $val) {
            echo $val;
            if (!(isset($val))) {
                return false;
            } else if (empty($val)) {
                Utils::addErrorMessage("Nie podano argumentu");
                return false;
            }
        }

//        if (!App::getMessages()->isError()) {
//            if ($this->form->login == "") {
//                Utils::addErrorMessage('Nie podano loginu');
//            }
//            if ($this->form->password == "") {
//                Utils::addErrorMessage('Nie podano hasła');
//            }
//        }

        if (!App::getMessages()->isError()) {
            try {
                $isAvailable = !(App::getDB()->has("user", [
                            "login" => $this->form->login
                ]));
            } catch (PDOException $ex) {
                Utils::addErrorMessage("Wystąpił błąd podczas pobierania rekordów");
            }


            if ($isAvailable) {
                //TODO: Validator, validate values before putting it inside DB

                try {
                    App::getDB()->insert("user", [
                        "login" => $this->form->login,
                        "password" => $this->form->password,
                        "email" => $this->form->email,
                        "name" => $this->form->name,
                        "surname" => $this->form->surname,
                        "phone_number" => $this->form->phone_number,
                        "birth_date" => $this->form->birth_date,
                    ]);
                    Utils::addInfoMessage("Pomyślnie zarejestrowano!");
                } catch (PDOException $ex) {
                    Utils::addErrorMessage("Wystąpił błąd podczas pobierania rekordów");
                }
            } else {
                Utils::addErrorMessage("Konto o podanej nazwie już istnieje!");
            }

//            if($login)
//            if (password_verify($this->form->pwd, $hashed_pwd)) {
//                //TODO: Get here all the user info and put it in session
//
//                $role = App::getDB()->get("user", [
//                    "[><]user_role" => "id_user_role"
//                        ], "user_role.name", [
//                    "login" => $this->form->login
//                ]);
//
//                $user = new User($this->form->login, $role);
//                SessionUtils::storeObject("user", $user);
//                RoleUtils::addRole($role);
//            } else {
//                Utils::addErrorMessage("Niepoprawny login lub hasło!");
//            }
        }

        return !App::getMessages()->isError();
    }

    public function action_register() {
        $this->getParams();

        if ($this->validate()) {
//            App::getRouter()->redirectTo("main");
        } else {
            $this->generateView();
        }
    }

    public function generateView() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject("user", true));

        App::getSmarty()->display("RegisterView.tpl");
    }

}
