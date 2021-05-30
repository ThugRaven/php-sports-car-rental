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
        $this->form->rent_end = ParamUtils::getFromRequest('rent_end');
        $this->form->total_price = ParamUtils::getFromRequest('total_price');
        $this->form->deposit = ParamUtils::getFromRequest('deposit');
        $this->form->payment_type = ParamUtils::getFromRequest('payment_type');
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
        if ($this->form->step == 'step-1') {
            $this->rent_step_1();
        } else if ($this->form->step == 'step-2') {
            $this->rent_step_2();
        } else if ($this->form->step == 'step-3') {
            $this->rent_step_3();
        }
    }

    private function rent_step_1() {
//          $start = strtotime($this->form->rent_start);
//            $end = strtotime($this->form->rent_end);
//            $date_diff = abs($start - $end)/(60*60);
//            print_r($date_diff);
//            echo 'Godziny: '.$date_diff.'\n';

        $start = new DateTime($this->form->rent_start);
        $end = new DateTime($this->form->rent_end);
        $date_diff = $start->diff($end);
        print_r($date_diff);

//            $hours = $date_diff->h;
//            $hours = $hours + ($date_diff->days * 24);
//            if ($date_diff->i > 0) {
//                $hours++;
//            }
//
//            echo $hours;
        $days = $date_diff->days;
        if ($date_diff->h > 0) {
            $days++;
        }
        echo $days;
        echo '\n';
        print_r($this->form);

        $where['id_car'] = $this->form->id_car;
        try {
            $this->records = App::getDB()->get('car', [
                '[><]car_price' => 'id_car_price'
                    ], [
                'car.id_car',
                'car.brand',
                'car.model',
                'car.eng_power',
                'car.eng_torque',
                'car_price.price_deposit',
                'car_price.price_no_deposit',
                'car_price.km_limit',
                'car_price.deposit',
                'car_price.additional_km'
                    ], $where);
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }
        print_r($this->records);

        if (!isset($this->form->deposit)) {
            $this->form->total_price = $this->records['price_deposit'] * $days;
        } else {
            $this->form->total_price = $this->records['price_no_deposit'] * $days;
        }
        echo 'step-1';
        $this->assignSmarty();
        App::getSmarty()->display('RentOptionsView.tpl');
    }

    private function rent_step_2() {
        echo 'step-2';
        print_r($this->form);
        
        
        
        $this->assignSmarty();
        App::getSmarty()->display('RentSummaryView.tpl');
    }

    public function assignSmarty() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
        App::getSmarty()->assign('records', $this->records);
    }

}
