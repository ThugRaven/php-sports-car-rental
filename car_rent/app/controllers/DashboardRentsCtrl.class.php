<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\SessionUtils;
use app\forms\RentsForm;
use app\forms\RentEditForm;
use core\Validator;
use core\DBUtils;

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
            array('rent.id_rent-asc', 'ID: rosnąco'),
            array('rent.id_rent-desc', 'ID: malejąco'),
            array('rent.create_time-desc', 'Czas dodania: od najnowszych'),
            array('rent.create_time-asc', 'Czas dodania: od najstarszych'),
            array('rent.distance-desc', 'Dystans: od najdłuższych'),
            array('rent.distance-asc', 'Dystans: od najkrótszych'),
            array('rent.total_price-desc', 'Cena: od najdroższych'),
            array('rent.total_price-asc', 'Cena: od najtańszych')
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
        $this->form->id_rent = ParamUtils::getFromRequest('id_rent');
        $this->form->id_car = ParamUtils::getFromRequest('id_car');
        $this->form->id_user = ParamUtils::getFromRequest('id_user');
        $this->form->status = ParamUtils::getFromRequest('status');
        $this->form->order = ParamUtils::getFromRequest('order');
        $this->form->deposit = ParamUtils::getFromRequest('deposit');
        $this->form->payment_type = ParamUtils::getFromRequest('payment_type');
        $this->form->page_size = ParamUtils::getFromRequest('page_size');

        $cars = DBUtils::select('car', null, ['id_car', 'brand', 'model'], null);

        App::getSmarty()->assign('cars', $cars);
        App::getSmarty()->assign('orders', $this->orders);

        $this->search_params = DBUtils::prepareParam($this->form->id_rent, 'id_rent', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->id_car, 'id_car', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->id_user, 'id_user', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->status, 'status', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->deposit, 'deposit', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->payment_type, 'payment_type', $this->search_params);

        $where = DBUtils::prepareWhere($this->search_params, $this->form->order, 'id_rent');

        $numOfRecords = DBUtils::count('rent', [
                    '[><]rent_status' => 'id_rent_status',
                    '[><]car' => 'id_car'
                        ], '*', $where);
        $where['LIMIT'] = DBUtils::preparePagination($numOfRecords, $this->form->page_size);

        $this->records = DBUtils::select('rent', [
                    '[><]rent_status' => 'id_rent_status',
                    '[><]car' => 'id_car'
                        ], '*', $where);

        App::getSmarty()->assign('pageRecords', count($this->records));

        for ($i = 0; $i < count($this->records); $i++) {
            $this->records[$i]['brand_url'] = trim($this->records[$i]['brand']);
            $this->records[$i]['model_url'] = trim($this->records[$i]['model']);
            $this->records[$i]['brand_url'] = strtolower($this->records[$i]['brand_url']);
            $this->records[$i]['model_url'] = strtolower($this->records[$i]['model_url']);
            $this->records[$i]['brand_url'] = preg_replace('/\s+/', '-', $this->records[$i]['brand_url']);
            $this->records[$i]['model_url'] = preg_replace('/\s+/', '-', $this->records[$i]['model_url']);
        }

        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('page_title', 'Dashboard - Wynajmy');
        App::getSmarty()->assign('form_name', 'dash-rents-form');
        App::getSmarty()->assign('form_action', 'dashboardRentsList');
        App::getSmarty()->assign('form_table', 'dash-rents-table');
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

        $isValid = DBUtils::has('rent', null, [
                    'id_rent' => $this->form_edit->id_rent
        ]);

        if (!$isValid) {
            Utils::addErrorMessage('Brak podanego wynajmu');
            return false;
        }

        $this->rent = DBUtils::get('rent', null, [
                    'id_rent',
                    'id_car',
                    'id_user',
                    'rent_start',
                    'rent_end',
                    'id_rent_status',
                    'distance',
                    'deposit',
                    'total_price',
                    'payment_type',
                        ], [
                    'id_rent' => $this->form_edit->id_rent
        ]);

        $rent_statuses = DBUtils::select('rent_status', null, ['id_rent_status', 'status']);

        App::getSmarty()->assign('inputs', $this->inputs);
        App::getSmarty()->assign('rent', $this->rent);
        App::getSmarty()->assign('rent_statuses', $rent_statuses);
        App::getSmarty()->assign('page_title', 'Dashboard - Wynajmy - Edycja');
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

        $isValid = DBUtils::has('rent', null, [
                    'id_rent' => $this->form_edit->id_rent
                        ], true);

        print_r($this->form_edit);

        if (!$isValid) {
            Utils::addErrorMessage('Brak podanego wynajmu');
            return false;
        }

        $rent_old = DBUtils::get('rent', null, '*', [
                    'id_rent' => $this->form_edit->id_rent
                        ], true);

        $this->form_edit->deposit = DBUtils::getCheckbox($this->form_edit->deposit);

        $column_params = [];
        print_r($rent_old);
        echo "<pre>";
        foreach ($rent_old as $key => $value) {
            if ($key === 'id_car' || $key === 'id_user' || $key === 'create_time') {
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


        if (count($columns) < 1) {
            Utils::addInfoMessage('Brak zmian');
        } else {
            if (!App::getMessages()->isError()) {
                DBUtils::update('rent', $columns, [
                    'id_rent' => $this->form_edit->id_rent
                        ], true);
                Utils::addInfoMessage('Zapisano!');
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
            App::getRouter()->redirectTo('main');
        }
    }

    public function action_dashboardRentsList() {
        if ($this->processDashRents()) {
            App::getSmarty()->display('DashboardRentsTable.tpl');
        } else {
            SessionUtils::storeMessages();
            App::getRouter()->redirectTo('main');
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
            App::getRouter()->redirectTo('dashboardRents');
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
