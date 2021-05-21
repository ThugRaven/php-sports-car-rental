<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\transfer\User;
use app\forms\CarsForm;

class CarsCtrl {

    private $form;
    private $records;

    public function __construct() {
        $this->form = new CarsForm();
    }

    public function getParams() {
        $this->form->model = ParamUtils::getFromRequest('model');
    }

    public function validate() {
//        return !getMessages()->hasErrors();
    }

    public function action_cars() {
        $this->getParams();
        $this->validate();

        $search_params = [];
//        if (isset($this->form->amount) && !empty($this->form->amount) && is_numeric($this->form->amount)) {
//            $search_params['amount'] = $this->form->amount;
//        }
        $search_params['model[~]'] = $this->form->model;

        $num_params = sizeof($search_params);
        if ($num_params > 1) {
            $where = ["AND" => &$search_params];
        } else {
            $where = &$search_params;
        }
        $where["ORDER"] = ["brand", "model"];

        try {
            $this->records = App::getDB()->select("car", [
                "id_car",
                "brand",
                "model",
                "eng_power",
                "eng_torque"
                    ], $where);
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        $this->generateView();
    }

    public function action_car() {
        $this->form->id_car = ParamUtils::getFromCleanURL(1);
        $where["id_car"] = $this->form->id_car;
        $this->records = App::getDB()->get("car", [
            "id_car",
            "brand",
            "model",
            "eng_power",
            "eng_torque"
                ], $where);

        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject("user", true));
        App::getSmarty()->assign('records', $this->records);

        App::getSmarty()->display("CarView.tpl");
    }

    public function generateView() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject("user", true));
        App::getSmarty()->assign('records', $this->records);

        App::getSmarty()->display("CarsListView.tpl");
    }

}
