<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\transfer\User;
use app\forms\CarsForm;
use app\forms\RentForm;

class CarsCtrl {

    private $form;
    private $form_rent;
    private $records;
    private $search_params;

    public function __construct() {
        $this->form = new CarsForm();
        $this->form_rent = new RentForm();
        $this->search_params = [];
    }

    public function getParams() {
        $this->form->model = ParamUtils::getFromRequest('model');
        $this->form->brand = ParamUtils::getFromRequest('brand');
    }

    public function validate() {
//        return !getMessages()->hasErrors();
    }

    public function action_cars() {
        $this->getParams();
        $this->validate();

        try {
            $brands = App::getDB()->select("car", "@brand");
//            print_r(App::getDB()->debug()->select("car", "@brand"));
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        print_r($brands);
        print_r($this->form->brand);
        App::getSmarty()->assign('brands', $brands);
        if (isset($this->form->brand) && !$this->form->brand == "") {
            $this->search_params['brand'] = $this->form->brand;
        }

//        if (isset($this->form->amount) && !empty($this->form->amount) && is_numeric($this->form->amount)) {
//            $search_params['amount'] = $this->form->amount;
//        }
        if (isset($this->form->model) && !$this->form->model == "") {
            $this->search_params['model[~]'] = $this->form->model;
        }

        $num_params = count($this->search_params);
        if ($num_params > 1) {
            $where = ["AND" => &$this->search_params];
        } else {
            $where = &$this->search_params;
        }
        $where["ORDER"] = ["brand", "model"];

        print_r($where);

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
        for ($i = 0; $i < count($this->records); $i++) {
            $this->records[$i]["brand_url"] = trim($this->records[$i]["brand"]);
            $this->records[$i]["model_url"] = trim($this->records[$i]["model"]);
            $this->records[$i]["brand_url"] = strtolower($this->records[$i]["brand_url"]);
            $this->records[$i]["model_url"] = strtolower($this->records[$i]["model_url"]);
            $this->records[$i]["brand_url"] = preg_replace("/\s+/", "-", $this->records[$i]["brand_url"]);
            $this->records[$i]["model_url"] = preg_replace("/\s+/", "-", $this->records[$i]["model_url"]);
        }
//        print_r($this->records);
        $this->generateView();
    }

    public function action_car() {
        $this->form_rent->id_car = ParamUtils::getFromCleanURL(1);
        $where["id_car"] = $this->form_rent->id_car;

        try {
            $this->records = App::getDB()->get("car", [
                "[><]car_price" => "id_car_price"
                    ], "*", $where);
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        $this->form_rent->id_car_price = $this->records["id_car_price"];

        App::getSmarty()->assign('form', $this->form_rent);
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
