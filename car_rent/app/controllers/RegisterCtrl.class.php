<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use core\Validator;
use app\transfer\User;
use app\forms\RegisterForm;
use core\DBUtils;

class RegisterCtrl {

    private $form;
    private $v;

    public function __construct() {
        $this->form = new RegisterForm();
        $this->v = new Validator();
    }

    public function getParamsValid() {
        $this->form->login = $this->v->validateFromRequest('login', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Pole Login jest wymagane',
            'max_length' => 45,
            'validator_message' => 'Maksymalna długość loginu to 45 znaków!'
        ]);
        $this->form->password = $this->v->validateFromRequest('password', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Pole Hasło jest wymagane',
            'max_length' => 72,
            'validator_message' => 'Maksymalna długość hasła to 72 znaków!'
        ]);
        $this->form->password_v = $this->v->validateFromRequest('password_v', [
            'trim' => true,
        ]);
        $this->form->email = $this->v->validateFromRequest('email', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Pole Email jest wymagane',
            'email' => true,
            'validator_message' => 'Podano zły format email!'
        ]);
        $this->form->name = $this->v->validateFromRequest('name', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Pole Imię jest wymagane',
            'max_length' => 45,
            'validator_message' => 'Maksymalna długość imienia to 45 znaków!'
        ]);
        $this->form->surname = $this->v->validateFromRequest('surname', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Pole Nazwisko jest wymagane',
            'max_length' => 45,
            'validator_message' => 'Maksymalna długość nazwiska to 45 znaków!'
        ]);
        $this->form->phone_number = $this->v->validateFromRequest('phone_number', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Pole Numer telefonu jest wymagane',
            'max_length' => 15,
            'validator_message' => 'Maksymalna długość numeru telefonu to 15 znaków!'
        ]);
        $birth_date = $this->v->validateFromRequest('birth_date', [
            'trim' => true,
            'required' => true,
            'required_message' => 'Pole Data urodzenia jest wymagane',
            'date_format' => 'Y-m-d',
            'validator_message' => 'Niepoprawny format daty. Przykład: 2001-04-15'
        ]);
        if ($this->v->isLastOK()) {
            $this->form->birth_date = $birth_date->format('Y-m-d');
        }
    }

    public function validate() {
        if (strcmp($this->form->password_v, $this->form->password) != 0) {
            Utils::addErrorMessage('Hasła nie są takie same!');
            return false;
        }

        return !App::getMessages()->isError();
    }

    public function action_registration() {
        $this->generateView();
    }

    public function action_register() {
        $this->getParamsValid();

        if ($this->validate()) {
            $isAvailable = !(DBUtils::has('user', null, [
                        'login' => $this->form->login
            ]));

            if ($isAvailable) {
                DBUtils::insert('user', [
                    'login' => $this->form->login,
                    'password' => password_hash($this->form->password, PASSWORD_BCRYPT),
                    'email' => $this->form->email,
                    'name' => $this->form->name,
                    'surname' => $this->form->surname,
                    'phone_number' => $this->form->phone_number,
                    'birth_date' => $this->form->birth_date,
                ]);

                Utils::addInfoMessage('Pomyślnie zarejestrowano!');
            } else {
                Utils::addErrorMessage('Konto o podanej nazwie już istnieje!');
            }

            SessionUtils::storeMessages();
            App::getRouter()->redirectTo('main');
        } else {
            $this->generateView();
        }
    }

    public function generateView() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));

        App::getSmarty()->display('RegisterView.tpl');
    }

}
