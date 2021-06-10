<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\transfer\User;
use app\forms\RentsForm;
use app\forms\RentEditForm;
use core\Validator;

class DashboardRentsCtrl {

    private $form;
    private $records;
    private $search_params;
    private $orders;
    private $inputs;
    private $v;

    public function __construct() {
        $this->form = new RentsForm();
        $this->form_edit = new RentEditForm();
        $this->search_params = [];
        $this->orders = [
//            array('', 'Alfabetycznie'),
            array('rent.id_rent-asc', 'ID rosnąco'),
            array('rent.id_rent-desc', 'ID malejąco'),
            array('rent.create_time-desc', 'Najnowsze'),
            array('rent.create_time-asc', 'Najstarsze'),
            array('rent.distance-desc', 'Najdłuższe'),
            array('rent.distance-asc', 'Najkrótsze'),
            array('rent.total_price-desc', 'Najdroższe'),
            array('rent.total_price-asc', 'Najtańsze')
        ];
        $this->inputs = [
            'id_rent' => ['ID Wynajmu', false],
            'id_car' => ['ID Samochodu', false],
            'id_user' => ['ID Użytkownika', false],
            'rent_start' => ['Początek wynajmu', false],
            'rent_end' => ['Koniec wynajmu', false],
            'id_rent_status' => ['Status', false],
            'distance' => ['Dystans', false],
            'deposit' => ['Kaucja', false],
            'total_price' => ['Całkowita kwota', false],
            'payment_type' => ['Rodzaj płatności', false],
        ];
        $this->v = new Validator();
    }

    public function processDashRents() {
        $this->form->id_car = ParamUtils::getFromRequest('id_car');
        $this->form->id_rent = ParamUtils::getFromRequest('id_rent');
        $this->form->status = ParamUtils::getFromRequest('status');
        $this->form->order = ParamUtils::getFromRequest('order');
        $this->form->deposit = ParamUtils::getFromRequest('deposit');
        $this->form->payment_type = ParamUtils::getFromRequest('payment_type');

        try {
            $cars = App::getDB()->select('car', ['id_car', 'brand', 'model']);
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        App::getSmarty()->assign('cars', $cars);
        App::getSmarty()->assign('orders', $this->orders);

        if (isset($this->form->id_car) && $this->form->id_car != '') {
            $this->search_params['id_car'] = $this->form->id_car;
        }

        if (isset($this->form->id_rent) && $this->form->id_rent != '') {
            $this->search_params['id_rent'] = $this->form->id_rent;
        }

        if (isset($this->form->status) && $this->form->status != '') {
            $this->search_params['status'] = $this->form->status;
        }

        if (isset($this->form->deposit) && $this->form->deposit != '') {
            $this->search_params['deposit'] = $this->form->deposit;
        }

        if (isset($this->form->payment_type) && $this->form->payment_type != '') {
            $this->search_params['payment_type'] = $this->form->payment_type;
        }

//        print_r($this->form->order);
        if (!empty($this->form->order)) {
            $order_params = explode('-', $this->form->order);
//            print_r($order_params);
            $order_params[$order_params[0]] = strtoupper($order_params[1]);
            unset($order_params[0]);
            unset($order_params[1]);
//            print_r($order_params);
        }

        $num_params = count($this->search_params);
        if ($num_params > 1) {
            $where = ['AND' => &$this->search_params];
        } else {
            $where = &$this->search_params;
        }

        if (isset($order_params) && count($order_params) > 0) {
            $where['ORDER'] = $order_params;
        } else {
            $where['ORDER'] = ['id_rent'];
        }
        print_r($where);

        try {
            print_r(App::getDB()->debug()->select('rent', [
                        '[><]rent_status' => 'id_rent_status'
                            ], '*', $where));

            $this->records = App::getDB()->select('rent', [
                '[><]rent_status' => 'id_rent_status'
                    ], '*', $where);
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        App::getSmarty()->assign('form', $this->form);
        $this->assignSmarty();
        return !App::getMessages()->isError();
    }

    public function processDashRentEdit() {
        $this->form_edit->id_rent = $this->v->validateFromCleanURL(1, [
            'trim' => true,
            'required' => true,
            'required_message' => 'ID wynajmu jest wymagane',
            'int' => true,
            'validator_message' => 'ID wynajmu musi być liczbą całkowitą'
        ]);

        $isValid = App::getDB()->has('rent', [
            'id_rent' => $this->form_edit->id_rent
        ]);
        if (!$isValid) {
            Utils::addErrorMessage('Brak podanego samochodu');
            return false;
        }

        try {
            $this->rent = App::getDB()->get('rent', '*', [
                'id_rent' => $this->form_edit->id_rent
            ]);

            $rent_statuses = App::getDB()->select('rent_status', ['id_rent_status', 'status']);

            print_r($this->rent);
            print_r($rent_statuses);
        } catch (\PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        App::getSmarty()->assign('inputs', $this->inputs);
        App::getSmarty()->assign('rent', $this->rent);
        App::getSmarty()->assign('rent_statuses', $rent_statuses);
        print_r($this->inputs);
        $this->assignSmarty();
        return !App::getMessages()->isError();
    }

    public function processDashRentSave() {
        $this->form_edit->id_rent = ParamUtils::getFromRequest('id_rent');
        $this->form_edit->rent_start = ParamUtils::getFromRequest('rent_start');
        $this->form_edit->rent_end = ParamUtils::getFromRequest('rent_end');
        $this->form_edit->id_rent_status = ParamUtils::getFromRequest('id_rent_status');
        $this->form_edit->distance = ParamUtils::getFromRequest('distance');
        $this->form_edit->deposit = ParamUtils::getFromRequest('deposit');
        $this->form_edit->total_price = ParamUtils::getFromRequest('total_price');
        $this->form_edit->payment_type = ParamUtils::getFromRequest('payment_type');

        $isValid = App::getDB()->has('rent', [
            'id_rent' => $this->form_edit->id_rent
        ]);

        print_r($this->form_edit);

        if (!$isValid) {
            Utils::addErrorMessage('Brak podanego wynajmu');
            return false;
        }

        try {
            $rent_old = App::getDB()->get('rent', '*', [
                'id_rent' => $this->form_edit->id_rent
            ]);

            if (isset($this->form_edit->deposit) && $this->form_edit->deposit === 'on') {
                $this->form_edit->deposit = 1;
            } else if (!isset($this->form_edit->deposit)) {
                $this->form_edit->deposit = 0;
            }

            $column_params = [];
            print_r($rent_old);
            echo "<pre>";
            foreach ($rent_old as $key => $value) {
                if ($key === 'id_car' || $key === 'id_user') {
                    continue;
                }
                $form_value = $this->form_edit->$key;
                echo "value: $value, key: $key, form: " . $form_value . "\n";
                if ($value != $form_value && $key === 'deposit') {
                    echo "1 $value is different, key: $key\n";
                    $column_params[$key] = $form_value;
                } else if ($value != $form_value && $this->inputs[$key][1]) {
                    echo "2 $value is different, key: $key\n";
                    $column_params[$key] = $form_value;
                } else if ($value != $form_value && isset($form_value) && !empty($form_value)) {
                    echo "3 $value is different, key: $key\n";
                    $column_params[$key] = $form_value;
                }
            }
            echo "</pre>";

            $columns = &$column_params;

            print_r($columns);
        } catch (\PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        if (count($columns) < 1) {
            Utils::addInfoMessage('Brak zmian');
        } else {
            if (!App::getMessages()->isError()) {
                try {
                    print_r(App::getDB()->debug()->update('rent', $columns, [
                                'id_rent' => $this->form_edit->id_rent
                    ]));

                    App::getDB()->update('rent', $columns, [
                        'id_rent' => $this->form_edit->id_rent
                    ]);

                    Utils::addInfoMessage('Zapisano!');
                } catch (\PDOException $ex) {
                    Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
                    if (App::getConf()->debug) {
                        Utils::addErrorMessage($ex->getMessage());
                    }
                }
            }
        }

        SessionUtils::storeMessages();

        $this->assignSmarty();
        return !App::getMessages()->isError();
    }

    public function action_dashboardRents() {
        if ($this->processDashRents()) {
            App::getSmarty()->display('DashboardRentsView.tpl');
        } else {
            App::getRouter()->redirectTo('dashboard');
        }
    }

    public function action_dashboardRentEdit() {
        if ($this->processDashRentEdit()) {
            App::getSmarty()->display('DashboardRentEditView.tpl');
        } else {
//            App::getRouter()->redirectTo('dashboardCars');
        }
    }

    public function action_dashboardRentSave() {
        if ($this->processDashRentSave()) {
//            App::getRouter()->redirectTo('dashboardRents');
//            App::getSmarty()->display('DashboardCarEditView.tpl');
        } else {
//            App::getRouter()->redirectTo('dashboardRents');
        }
    }

    public function assignSmarty() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
        App::getSmarty()->assign('records', $this->records);
    }

}
