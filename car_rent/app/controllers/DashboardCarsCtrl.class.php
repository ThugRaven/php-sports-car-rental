<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\transfer\User;
use app\forms\CarsForm;
use app\forms\CarEditForm;
use core\Validator;

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
            array('', 'Alfabetycznie'),
            array('car.id_car-desc', 'ID malejąco'),
            array('car.id_car-asc', 'ID rosnąco'),
            array('car_price.price_deposit-desc', 'Cena od największej'),
            array('car_price.price_deposit-asc', 'Cena od najmniejszej'),
            array('car.eng_power-desc', 'Moc silnika malejąco'),
            array('car.eng_power-asc', 'Moc silnika rosnąco'),
            array('car.eng_torque-desc', 'Moment obrotowy malejąco'),
            array('car.eng_torque-asc', 'Moment obrotowy rosnąco')
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
            'price_deposit' => ['Cena z kaucją', false],
            'price_no_deposit' => ['Cena bez kaucji', false],
            'km_limit' => ['Limit kilometrów', false],
            'deposit' => ['Kaucja', false],
            'additional_km' => ['Koszt dodatkowego kilometra', false],
        ];
        $this->v = new Validator();
    }

    public function processDashCars() {
        $this->form->model = ParamUtils::getFromRequest('model');
        $this->form->brand = ParamUtils::getFromRequest('brand');
        $this->form->order = ParamUtils::getFromRequest('order');
        $this->form->type = ParamUtils::getFromRequest('transmission_type');
        $this->form->drive = ParamUtils::getFromRequest('drive');

        try {
            $brands = App::getDB()->select('car', '@brand', [
                'ORDER' => 'brand'
            ]);
//            print_r(App::getDB()->debug()->select('car', '@brand', [
//                        'ORDER' => 'brand'
//            ]));
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        print_r($brands);
        print_r($this->form->brand);
        App::getSmarty()->assign('brands', $brands);
        App::getSmarty()->assign('orders', $this->orders);

        if (isset($this->form->brand) && !$this->form->brand == '') {
            $this->search_params['brand'] = $this->form->brand;
        }

        if (isset($this->form->model) && !$this->form->model == '') {
            $this->search_params['model[~]'] = $this->form->model;
        }

        if (isset($this->form->type) && !$this->form->type == '') {
            $this->search_params['transmission_type'] = $this->form->type;
        }

        if (isset($this->form->drive) && !$this->form->drive == '') {
            $this->search_params['drive'] = $this->form->drive;
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
            $where['ORDER'] = ['brand', 'model'];
        }
        print_r($where);

        try {
            print_r(App::getDB()->debug()->select('car', [
                        '[><]car_price' => 'id_car_price'
                            ], [
                        'car.id_car',
                        'car.brand',
                        'car.model',
                        'car.eng_power',
                        'car.eng_torque',
                        'car_price.price_deposit'
                            ], $where));

            $this->records = App::getDB()->select('car', [
                '[><]car_price' => 'id_car_price'
                    ], [
                'car.id_car',
                'car.brand',
                'car.model',
                'car.eng_power',
                'car.eng_torque',
                'car_price.price_deposit'
                    ], $where);
        } catch (PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }
        for ($i = 0; $i < count($this->records); $i++) {
            $this->records[$i]['brand_url'] = trim($this->records[$i]['brand']);
            $this->records[$i]['model_url'] = trim($this->records[$i]['model']);
            $this->records[$i]['brand_url'] = strtolower($this->records[$i]['brand_url']);
            $this->records[$i]['model_url'] = strtolower($this->records[$i]['model_url']);
            $this->records[$i]['brand_url'] = preg_replace('/\s+/', '-', $this->records[$i]['brand_url']);
            $this->records[$i]['model_url'] = preg_replace('/\s+/', '-', $this->records[$i]['model_url']);
        }
//        print_r($this->records);
        App::getSmarty()->assign('form', $this->form);
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

        $isValid = App::getDB()->has('car', [
            'id_car' => $this->form_edit->id_car
        ]);
        if (!$isValid) {
            Utils::addErrorMessage('Brak podanego samochodu');
            return false;
        }

        try {
            $this->car = App::getDB()->get('car', '*', [
                'id_car' => $this->form_edit->id_car
            ]);

            $this->car_price = App::getDB()->get('car_price', '*', [
                'id_car_price' => $this->car['id_car_price']
            ]);

            $car_prices = App::getDB()->select('car_price', 'id_car_price');

            print_r($this->car);
            print_r($this->car_price);
            print_r($car_prices);
        } catch (\PDOException $ex) {
            Utils::addErrorMessage('Wystąpił błąd podczas pobierania rekordów');
            if (App::getConf()->debug) {
                Utils::addErrorMessage($ex->getMessage());
            }
        }

        App::getSmarty()->assign('inputs', $this->inputs);
        App::getSmarty()->assign('car', $this->car);
        App::getSmarty()->assign('car_price', $this->car_price);
        App::getSmarty()->assign('car_prices', $car_prices);
        print_r($this->inputs);
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

            $isValid = App::getDB()->has('car', [
                'id_car' => $this->form_edit->id_car
            ]);
        } else if ($this->type === 'car_price') {
            $this->form_edit->id_car_price = ParamUtils::getFromRequest('id_car_price');
            $this->form_edit->price_deposit = ParamUtils::getFromRequest('price_deposit');
            $this->form_edit->price_no_deposit = ParamUtils::getFromRequest('price_no_deposit');
            $this->form_edit->km_limit = ParamUtils::getFromRequest('km_limit');
            $this->form_edit->deposit = ParamUtils::getFromRequest('deposit');
            $this->form_edit->additional_km = ParamUtils::getFromRequest('additional_km');

            $isValid = App::getDB()->has('car', [
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

        try {
            if ($this->type === 'car') {
                $car_old = App::getDB()->get('car', '*', [
                    'id_car' => $this->form_edit->id_car
                ]);
            } else if ($this->type === 'car_price') {
                $car_old = App::getDB()->get('car_price', '*', [
                    'id_car_price' => $this->form_edit->id_car_price
                ]);
            }

            if (isset($this->form_edit->rentable) && $this->form_edit->rentable === 'on') {
                $this->form_edit->rentable = 1;
            } else if (!isset($this->form_edit->rentable)) {
                $this->form_edit->rentable = 0;
            }

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
                    if ($this->type === 'car') {
                        print_r(App::getDB()->debug()->update('car', $columns, [
                                    'id_car' => $this->form_edit->id_car
                        ]));

                        App::getDB()->update('car', $columns, [
                            'id_car' => $this->form_edit->id_car
                        ]);
                    } else if ($this->type === 'car_price') {
                        print_r(App::getDB()->debug()->update('car_price', $columns, [
                                    'id_car_price' => $this->form_edit->id_car_price
                        ]));

                        App::getDB()->update('car_price', $columns, [
                            'id_car_price' => $this->form_edit->id_car_price
                        ]);
                    }

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

    public function action_dashboardCars() {
        if ($this->processDashCars()) {
            App::getSmarty()->display('DashboardCarsView.tpl');
        } else {
            App::getRouter()->redirectTo('dashboard');
        }
    }

    public function action_dashboardCarEdit() {
        if ($this->processDashCarEdit()) {
            App::getSmarty()->display('DashboardCarEditView.tpl');
        } else {
//            App::getRouter()->redirectTo('dashboardCars');
        }
    }

    public function action_dashboardCarSave() {
        if ($this->processDashCarSave()) {
            App::getRouter()->redirectTo('dashboardCars');
//            App::getSmarty()->display('DashboardCarEditView.tpl');
        } else {
//            App::getRouter()->redirectTo('dashboardCars');
        }
    }

    public function assignSmarty() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
        App::getSmarty()->assign('records', $this->records);
    }

}
