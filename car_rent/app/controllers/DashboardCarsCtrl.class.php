<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\SessionUtils;
use app\forms\CarsForm;
use app\forms\CarEditForm;
use core\Validator;
use core\DBUtils;

class DashboardCarsCtrl {

    private $form;
    private $records;
    private $search_params;
    private $orders;
    private $inputs;
    private $v;

    public function __construct() {
        $this->form = new CarsForm();
        $this->form_edit = new CarEditForm();
        $this->search_params = [];
        $this->orders = [
            array('', 'Nazwa: A-Z'),
            array('car.brand-desc', 'Nazwa: Z-A'),
            array('car.id_car-desc', 'ID: malejąco'),
            array('car.id_car-asc', 'ID: rosnąco'),
            array('car_price.price_deposit-desc', 'Cena: od najdroższych'),
            array('car_price.price_deposit-asc', 'Cena: od najtańszych'),
            array('car.eng_power-desc', 'Moc silnika: od największej'),
            array('car.eng_power-asc', 'Moc silnika: od najmniejszej'),
            array('car.eng_torque-desc', 'Moment obrotowy: malejąco'),
            array('car.eng_torque-asc', 'Moment obrotowy rosnąco'),
            array('car.rentable-asc', 'Wypożyczalne: malejąco'),
            array('car.rentable-desc', 'Wypożyczalne: rosnąco'),
            array('car.main_page-asc', 'Galeria: malejąco'),
            array('car.main_page-desc', 'Galeria: rosnąco')
        ];
        $this->inputs = [
            'id_car' => ['ID Samochodu', false],
            'id_car_price' => ['ID Cen samochodu', false],
            'license_plate' => ['Tablica rejestracyjna', false],
            'mileage' => ['Przebieg', false],
            'brand' => ['Marka', false],
            'model' => ['Model', false],
            'eng_power' => ['Moc silnika', false],
            'eng_torque' => ['Moment obrotowy', false],
            'eng_info' => ['Informacje o silniku', true],
            'eng_displacement' => ['Pojemność silnika', false],
            'drive' => ['Napęd', false],
            'time_100' => ['Czas do 100km/h', true],
            'top_speed' => ['Maksymalna prędkość', true],
            'fuel_type' => ['Rodzaj paliwa', false],
            'transmission_type' => ['Skrzynia biegów', false],
            'doors' => ['Liczba drzwi', true],
            'seats' => ['Liczba siedzeń', true],
            'weight' => ['Waga', true],
            'fuel_capacity' => ['Pojemność paliwa', true],
            'fuel_consumption' => ['Zużycie paliwa', true],
            'rentable' => ['Wypożyczalny', false],
            'main_page' => ['Galeria', true],
            'price_deposit' => ['Cena z kaucją', false],
            'price_no_deposit' => ['Cena bez kaucji', false],
            'km_limit' => ['Limit kilometrów', false],
            'deposit' => ['Kaucja', false],
            'additional_km' => ['Koszt dodatkowego km', false],
        ];
        $this->v = new Validator();
    }

    public function processDashCars() {
        $this->form->model = ParamUtils::getFromRequest('model');
        $this->form->brand = ParamUtils::getFromRequest('brand');
        $this->form->order = ParamUtils::getFromRequest('order');
        $this->form->type = ParamUtils::getFromRequest('transmission_type');
        $this->form->drive = ParamUtils::getFromRequest('drive');
        $this->form->page_size = ParamUtils::getFromRequest('page_size');

        $brands = DBUtils::select('car', null, '@brand', [
                    'ORDER' => 'brand'
        ]);

        App::getSmarty()->assign('brands', $brands);
        App::getSmarty()->assign('orders', $this->orders);

        $this->search_params = DBUtils::prepareParam($this->form->brand, 'brand', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->model, 'model[~]', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->type, 'transmission_type', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->drive, 'drive', $this->search_params);

        $where = DBUtils::prepareWhere($this->search_params, $this->form->order, ['brand', 'model']);

        $numOfRecords = DBUtils::count('car', [
                    '[><]car_price' => 'id_car_price'
                        ], '*', $where);
        $where['LIMIT'] = DBUtils::preparePagination($numOfRecords, $this->form->page_size);

        $this->records = DBUtils::select('car', [
                    '[><]car_price' => 'id_car_price'
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
        App::getSmarty()->assign('page_title', 'Dashboard - Samochody');
        App::getSmarty()->assign('form_name', 'dash-cars-form');
        App::getSmarty()->assign('form_action', 'dashboardCarsList');
        App::getSmarty()->assign('form_table', 'dash-cars-table');
        $this->assignSmarty();
        return !App::getMessages()->isError();
    }

    public function processDashCarEdit() {
        $this->form_edit->id_car = $this->v->validateFromCleanURL(1, [
            'trim' => true,
            'required' => true,
            'required_message' => 'ID samochodu jest wymagane',
            'int' => true,
            'validator_message' => 'ID samochodu musi być liczbą całkowitą'
        ]);

        $isValid = DBUtils::has('car', null, [
                    'id_car' => $this->form_edit->id_car
        ]);

        if (!$isValid) {
            Utils::addErrorMessage('Brak podanego samochodu');
            return false;
        }

        $this->car = DBUtils::get('car', null, '*', [
                    'id_car' => $this->form_edit->id_car
        ]);

        $this->car_price = DBUtils::get('car_price', null, '*', [
                    'id_car_price' => $this->car['id_car_price']
        ]);

        $car_prices = DBUtils::select('car_price', null, 'id_car_price');

        App::getSmarty()->assign('inputs', $this->inputs);
        App::getSmarty()->assign('car', $this->car);
        App::getSmarty()->assign('car_price', $this->car_price);
        App::getSmarty()->assign('car_prices', $car_prices);
        App::getSmarty()->assign('page_title', 'Dashboard - Samochody - Edycja');
        $this->assignSmarty();
        return !App::getMessages()->isError();
    }

    public function processDashCarSave() {
        $this->type = $this->v->validateFromCleanURL(1, [
            'trim' => true,
            'required' => true,
        ]);

        if ($this->type === 'car') {
            $this->form_edit->id_car = ParamUtils::getFromRequest('id_car');
            $this->form_edit->id_car_price = ParamUtils::getFromRequest('id_car_price');
            $this->form_edit->license_plate = ParamUtils::getFromRequest('license_plate');
            $this->form_edit->mileage = ParamUtils::getFromRequest('mileage');
            $this->form_edit->brand = ParamUtils::getFromRequest('brand');
            $this->form_edit->model = ParamUtils::getFromRequest('model');
            $this->form_edit->eng_power = ParamUtils::getFromRequest('eng_power');
            $this->form_edit->eng_torque = ParamUtils::getFromRequest('eng_torque');
            $this->form_edit->eng_info = ParamUtils::getFromRequest('eng_info');
            $this->form_edit->eng_displacement = ParamUtils::getFromRequest('eng_displacement');
            $this->form_edit->drive = ParamUtils::getFromRequest('drive');
            $this->form_edit->time_100 = ParamUtils::getFromRequest('time_100');
            $this->form_edit->top_speed = ParamUtils::getFromRequest('top_speed');
            $this->form_edit->fuel_type = ParamUtils::getFromRequest('fuel_type');
            $this->form_edit->transmission_type = ParamUtils::getFromRequest('transmission_type');
            $this->form_edit->doors = ParamUtils::getFromRequest('doors');
            $this->form_edit->seats = ParamUtils::getFromRequest('seats');
            $this->form_edit->weight = ParamUtils::getFromRequest('weight');
            $this->form_edit->fuel_capacity = ParamUtils::getFromRequest('fuel_capacity');
            $this->form_edit->fuel_consumption = ParamUtils::getFromRequest('fuel_consumption');
            $this->form_edit->rentable = ParamUtils::getFromRequest('rentable');
            $this->form_edit->main_page = ParamUtils::getFromRequest('main_page');


            $isValid = DBUtils::has('car', null, [
                        'id_car' => $this->form_edit->id_car
            ]);
        } else if ($this->type === 'car_price') {
            $this->form_edit->id_car_price = ParamUtils::getFromRequest('id_car_price');
            $this->form_edit->price_deposit = ParamUtils::getFromRequest('price_deposit');
            $this->form_edit->price_no_deposit = ParamUtils::getFromRequest('price_no_deposit');
            $this->form_edit->km_limit = ParamUtils::getFromRequest('km_limit');
            $this->form_edit->deposit = ParamUtils::getFromRequest('deposit');
            $this->form_edit->additional_km = ParamUtils::getFromRequest('additional_km');

            $isValid = DBUtils::has('car', [
                        '[><]car_price' => 'id_car_price'
                            ], [
                        'id_car_price' => $this->form_edit->id_car_price
            ]);
        } else {
            Utils::addErrorMessage('Brak podanego samochodu');
            return false;
        }

        print_r($this->form_edit);

        if (!$isValid) {
            Utils::addErrorMessage('Brak podanego samochodu');
            return false;
        }

        if ($this->type === 'car') {
            $car_old = DBUtils::get('car', null, '*', [
                        'id_car' => $this->form_edit->id_car
            ]);
        } else if ($this->type === 'car_price') {
            $car_old = DBUtils::get('car_price', null, '*', [
                        'id_car_price' => $this->form_edit->id_car_price
            ]);
        }

        $this->form_edit->rentable = DBUtils::getCheckbox($this->form_edit->rentable);

        $column_params = [];
        print_r($car_old);
        echo "<pre>";
        foreach ($car_old as $key => $value) {
            $form_value = $this->form_edit->$key;
            echo "value: $value, key: $key, form: " . $form_value . "\n";
            if ($value != $form_value && $key === 'rentable') {
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
                if ($this->type === 'car') {
                    DBUtils::update('car', $columns, [
                        'id_car' => $this->form_edit->id_car
                            ], true);
                } else if ($this->type === 'car_price') {
                    DBUtils::update('car_price', $columns, [
                        'id_car_price' => $this->form_edit->id_car_price
                            ], true);
                }

                Utils::addInfoMessage('Zapisano!');
            }
        }

        SessionUtils::storeMessages();

        $this->assignSmarty();
        return !App::getMessages()->isError();
    }

    public function processDashCarBlock() {
        $this->form_edit->id_car = $this->v->validateFromCleanURL(1, [
            'trim' => true,
            'required' => true,
            'required_message' => 'ID samochodu jest wymagane',
            'int' => true,
            'validator_message' => 'ID samochodu musi być liczbą całkowitą'
        ]);

        $isValid = DBUtils::has('car', null, [
                    'id_car' => $this->form_edit->id_car
        ]);

        if (!$isValid) {
            Utils::addErrorMessage('Brak podanego samochodu');
            return false;
        }

        $rentable = DBUtils::get('car', null, 'rentable', [
                    'id_car' => $this->form_edit->id_car
        ]);

        if ($rentable) {
            DBUtils::update('car', [
                'rentable' => 0
                    ], [
                'id_car' => $this->form_edit->id_car
                    ], true);
            Utils::addInfoMessage('Pomyślnie zablokowano pojazd!');
        } else {
            DBUtils::update('car', [
                'rentable' => 1
                    ], [
                'id_car' => $this->form_edit->id_car
                    ], true);
            Utils::addInfoMessage('Pomyślnie odblokowano pojazd!');
        }

        $this->assignSmarty();
        SessionUtils::storeMessages();
        return !App::getMessages()->isError();
    }

    public function action_dashboardCars() {
        if ($this->processDashCars()) {
            App::getSmarty()->display('DashboardCarsView.tpl');
        } else {
            App::getRouter()->redirectTo('main');
        }
    }

    public function action_dashboardCarsList() {
        if ($this->processDashCars()) {
            App::getSmarty()->display('DashboardCarsTable.tpl');
        } else {
            SessionUtils::storeMessages();
            App::getRouter()->redirectTo('main');
        }
    }

    public function action_dashboardCarEdit() {
        if ($this->processDashCarEdit()) {
            App::getSmarty()->display('DashboardCarEditView.tpl');
        } else {
            App::getRouter()->redirectTo('main');
        }
    }

    public function action_dashboardCarSave() {
        if ($this->processDashCarSave()) {
            App::getRouter()->redirectTo('dashboardCars');
        } else {
            App::getRouter()->redirectTo('main');
        }
    }

    public function action_dashboardCarBlock() {
        if ($this->processDashCarBlock()) {
            App::getRouter()->redirectTo('dashboardCars');
        }
    }

    public function assignSmarty() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
        App::getSmarty()->assign('records', $this->records);
    }

}
