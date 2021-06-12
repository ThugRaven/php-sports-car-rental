<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\transfer\Rent;
use app\forms\RentForm;
use DateTime;
use core\DBUtils;

class RentCtrl {

    private $form;
    private $records;
    private $rent;

    public function __construct() {
        $this->form = new RentForm();
    }

    public function action_rent() {
        if ($this->processRent()) {
            $this->assignSmarty();
            App::getSmarty()->display('RentOptionsView.tpl');
        } else {
            App::getRouter()->redirectTo('main');
        }
    }

    public function action_rented() {
        if ($this->processRented()) {
            $this->assignSmarty();
            App::getSmarty()->display('RentSummaryView.tpl');
        } else {
            App::getRouter()->redirectTo('main');
        }
    }

    private function processRent() {
        $this->form->id_car = ParamUtils::getFromRequest('id_car');
        $this->form->rent_start = ParamUtils::getFromRequest('rent_start');
        $this->form->rent_end = ParamUtils::getFromRequest('rent_end');
        $this->form->deposit = ParamUtils::getFromRequest('deposit');
        $this->form->payment_type = ParamUtils::getFromRequest('payment_type');

        $start = new DateTime($this->form->rent_start);
        $end = new DateTime($this->form->rent_end);
        $date_diff = $start->diff($end);
        $days = $date_diff->days;
        if ($date_diff->h > 0) {
            $days++;
        }
        echo $days;
        echo '\n';
        print_r($this->form);

        $where['id_car'] = $this->form->id_car;

        $this->records = DBUtils::get('car', [
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

        $this->form->id_user = DBUtils::get('user', null, 'id_user', [
                    'login' => SessionUtils::loadObject('user', true)->login]
        );

        print_r($this->records);

        if (!isset($this->form->deposit) || $this->form->deposit === 'deposit') {
            $this->form->total_price = $this->records['price_deposit'] * $days;
            $this->form->deposit = 'deposit';
            $deposit = 1;
        } else if ($this->form->deposit === 'no_deposit') {
            $this->form->total_price = $this->records['price_no_deposit'] * $days;
            $this->form->deposit = 'no_deposit';
            $deposit = 0;
        }

        if (!isset($this->form->payment_type)) {
            $this->form->payment_type = 'card';
        }

        $rent = new Rent($this->form->id_car, $this->form->id_user, $start->format('Y-m-d H:i:s'), $end->format('Y-m-d H:i:s'), $deposit, $this->form->total_price, $this->form->payment_type);
        SessionUtils::storeObject('rent', $rent);
        print_r($rent);

        SessionUtils::storeMessages();
        return !App::getMessages()->isError();
    }

    private function processRented() {
        $this->rent = SessionUtils::loadObject('rent');
        if (!isset($this->rent)) {
            Utils::addErrorMessage('Wystąpił błąd');
            return false;
        }

        print_r($this->form);

        try {
            $db = App::getDB();
            $db->action(function($db) {
                print_r($db->debug()->insert('rent', [
                            'id_car' => $this->rent->id_car,
                            'id_user' => $this->rent->id_user,
                            'rent_start' => $this->rent->rent_start,
                            'rent_end' => $this->rent->rent_end,
                            'distance' => 0,
                            'deposit' => $this->rent->deposit,
                            'total_price' => $this->rent->total_price,
                            'payment_type' => $this->rent->payment_type,
                ]));

                $db->insert('rent', [
                    'id_car' => $this->rent->id_car,
                    'id_user' => $this->rent->id_user,
                    'rent_start' => $this->rent->rent_start,
                    'rent_end' => $this->rent->rent_end,
                    'id_rent_status' => 1,
                    'distance' => 0,
                    'deposit' => $this->rent->deposit,
                    'total_price' => $this->rent->total_price,
                    'payment_type' => $this->rent->payment_type,
                ]);

                $db->update('user', [
                    'rents[+]' => 1
                        ], [
                    'id_user' => $this->rent->id_user
                ]);

                $user = $db->get('user', ['rents', 'verified'], [
                    'id_user' => $this->rent->id_user
                ]);

                if ($user['rents'] >= 5 && $user['verified'] == 0) {
                    $db->update('user', [
                        'verified' => 1
                            ], [
                        'id_user' => $this->rent->id_user
                    ]);
                }

                Utils::addInfoMessage('Pomyślnie wynajęto pojazd!');
            });
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        SessionUtils::storeMessages();
        return !App::getMessages()->isError();
    }

    public function assignSmarty() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
        App::getSmarty()->assign('records', $this->records);
    }

}
