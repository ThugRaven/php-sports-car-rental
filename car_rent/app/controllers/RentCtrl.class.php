<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\transfer\User;
use app\forms\RentForm;
use DateTime;

class RentCtrl {

    private $form;
    private $records;

    public function __construct() {
        $this->form = new RentForm();
    }

    public function getParams() {
        $this->form->id_car = ParamUtils::getFromRequest('id_car');
        $this->form->id_car_price = ParamUtils::getFromRequest('id_car_price');
        $this->form->rent_start = ParamUtils::getFromRequest('rent_start');
        $this->form->rent_end = ParamUtils::getFromRequest('rent_end');
        $this->form->step = ParamUtils::getFromCleanURL(1);
    }

    public function validate() {
        return !App::getMessages()->isError();
    }

    public function action_rent() {
        $this->getParams();
        if (!$this->validate()) {
            return false;
        }
        if ($this->form->step == "step-1") {
//            $start = strtotime($this->form->rent_start);
//            $end = strtotime($this->form->rent_end);
//            $date_diff = abs($start - $end)/(60*60);
//            print_r($date_diff);
//            echo "Godziny: ".$date_diff."\n";

            $start = new DateTime($this->form->rent_start);
            $end = new DateTime($this->form->rent_end);
            $date_diff = $start->diff($end);
            print_r($date_diff);

            $hours = $date_diff->h;
            $hours = $hours + ($date_diff->days * 24);
            if ($date_diff->i > 0) {
                $hours++;
            }

            echo $hours;
            echo "\n";

            $where["id_car_price"] = $this->form->id_car_price;
            $this->records = App::getDB()->get("car_price", "*", $where);
            print_r($this->records);

            $this->form->total_price = $this->records["price_deposit"] * $hours;
            echo "step-1";
            $this->assignSmarty();
            App::getSmarty()->display("RentSummaryView.tpl");
        } else if ($this->form->step == "step-2") {
            echo "step-2";
            $this->assignSmarty();
            App::getSmarty()->display("RentPaymentView.tpl");
        } else if ($this->form->step == "step-3") {
            echo "step-3";
            $this->assignSmarty();
            App::getSmarty()->display("RentPaymentView.tpl");
        }
    }

    public function assignSmarty() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject("user", true));
        App::getSmarty()->assign('records', $this->records);
    }

}