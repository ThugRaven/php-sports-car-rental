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

    private function processRent() {
        $this->form->id_car = ParamUtils::getFromRequest('id_car');
        $this->form->rent_start = ParamUtils::getFromRequest('rent_start');
        $this->form->rent_end = ParamUtils::getFromRequest('rent_end');

        $start = new DateTime($this->form->rent_start);
        $end = new DateTime($this->form->rent_end);
        $date_diff = $start->diff($end);
        $days = $date_diff->days;
        if ($date_diff->h > 0) {
            $days++;
        }

        $this->form->id_user = DBUtils::get('user', null, 'id_user', [
                    'login' => SessionUtils::loadObject('user', true)->login]
        );

        $where['id_car'] = $this->form->id_car;

        $this->records = DBUtils::get('car', [
                    '[><]car_price' => 'id_car_price'
                        ], [
                    'car_price.price_deposit',
                    'car_price.price_no_deposit'
                        ], $where);

        if (empty($this->records)) {
            Utils::addErrorMessage('Brak pojazdu o podanym ID!');
            return false;
        }
        App::getSmarty()->assign('car', $this->records);

        $rent = new Rent($this->form->id_car, $this->form->id_user, $start->format('Y-m-d H:i:s'), $end->format('Y-m-d H:i:s'), $days, '', '', '');
        SessionUtils::storeObject('rent', $rent);
        App::getSmarty()->assign('page_title', "Wynajem - Opcje");

        return !App::getMessages()->isError();
    }

    private function processRentSummary() {
        $this->form->deposit = ParamUtils::getFromRequest('deposit');
        $this->form->payment_type = ParamUtils::getFromRequest('payment_type');

        $this->rent = SessionUtils::loadObject('rent');
        if (!isset($this->rent)) {
            Utils::addErrorMessage('Wystąpił błąd');
            return false;
        }
        $this->rent->deposit = $this->form->deposit;
        $this->rent->payment_type = $this->form->payment_type;

        $where['id_car'] = $this->rent->id_car;

        $this->records = DBUtils::get('car', [
                    '[><]car_price' => 'id_car_price'
                        ], [
                    'car.id_car',
                    'car.brand',
                    'car.model',
                    'car_price.price_deposit',
                    'car_price.price_no_deposit'
                        ], $where);

        $this->records['model_url'] = trim($this->records['model']);
        $this->records['model_url'] = strtolower($this->records['model_url']);
        $this->records['model_url'] = preg_replace('/\s+/', '-', $this->records['model_url']);
        App::getSmarty()->assign('car', $this->records);

        if ($this->rent->deposit === 'deposit') {
            $this->rent->total_price = $this->records['price_deposit'] * $this->rent->rent_diff;
        } else if ($this->rent->deposit === 'no_deposit') {
            $this->rent->total_price = $this->records['price_no_deposit'] * $this->rent->rent_diff;
        }

        $rent = new Rent($this->rent->id_car, $this->rent->id_user, $this->rent->rent_start, $this->rent->rent_end, $this->rent->rent_diff, $this->rent->deposit, $this->rent->total_price, $this->rent->payment_type);
        SessionUtils::storeObject('rent', $rent);
        App::getSmarty()->assign('rent', $rent);
        App::getSmarty()->assign('page_title', "Wynajem - Podsumowanie");

        return !App::getMessages()->isError();
    }

    private function processRentFinal() {
        $this->rent = SessionUtils::loadObject('rent');
        if (!isset($this->rent)) {
            Utils::addErrorMessage('Wystąpił błąd');
            return false;
        }

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

                Utils::addInfoMessage('Samochód został pomyślnie zarezerwowany!');
            });
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas rezerwacji pojazdu!');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        return !App::getMessages()->isError();
    }

    public function assignSmarty() {
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
    }

    public function action_rent() {
        if ($this->processRent()) {
            $this->assignSmarty();
            App::getSmarty()->display('RentOptionsView.tpl');
        } else {
            SessionUtils::storeMessages();
            App::getRouter()->redirectTo('main');
        }
    }

    public function action_rentSummary() {
        if ($this->processRentSummary()) {
            $this->assignSmarty();
            App::getSmarty()->display('RentSummaryView.tpl');
        } else {
            SessionUtils::storeMessages();
            App::getRouter()->redirectTo('main');
        }
    }

    public function action_rentFinal() {
        if ($this->processRentFinal()) {
            $this->assignSmarty();
            SessionUtils::storeMessages();
            App::getRouter()->redirectTo('account/' . SessionUtils::loadObject('user', true)->login);
        } else {
            SessionUtils::storeMessages();
            App::getRouter()->redirectTo('main');
        }
    }

}
