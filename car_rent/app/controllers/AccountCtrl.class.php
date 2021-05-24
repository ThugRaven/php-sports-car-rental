<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\forms\LoginForm;

class AccountCtrl {

    private $form;
    private $records;

    public function __construct() {
        $this->form = new LoginForm();
    }

    public function getParams() {
        $this->form->login = ParamUtils::getFromCleanURL(1);
    }

    public function validate() {
        if (!(isset($this->form->login))) {
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
        $this->getParams();
        $this->validate();
        $this->generateView();
    }

    public function generateView() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('records', $this->records);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));

        App::getSmarty()->display('AccountView.tpl');
    }

}
