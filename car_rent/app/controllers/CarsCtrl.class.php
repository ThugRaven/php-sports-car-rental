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
use core\Validator;
use core\DBUtils;

class CarsCtrl {

    private $form;
    private $form_rent;
    private $records;
    private $search_params;
    private $orders;
    private $v;

    public function __construct() {
        $this->v = new Validator();
        $this->form = new CarsForm();
        $this->form_rent = new RentForm();
        $this->search_params = [];
        $this->orders = [
            array('', 'Alfabetycznie'),
            array('car_price.price_deposit-desc', 'Cena od największej'),
            array('car_price.price_deposit-asc', 'Cena od najmniejszej'),
            array('car.eng_power-desc', 'Moc silnika malejąco'),
            array('car.eng_power-asc', 'Moc silnika rosnąco'),
            array('car.eng_torque-desc', 'Moment obrotowy malejąco'),
            array('car.eng_torque-asc', 'Moment obrotowy rosnąco')
        ];
    }

    public function processCars() {
        $this->form->model = ParamUtils::getFromRequest('model');
        $this->form->brand = ParamUtils::getFromRequest('brand');
        $this->form->order = ParamUtils::getFromRequest('order');
        $this->form->type = ParamUtils::getFromRequest('transmission_type');
        $this->form->drive = ParamUtils::getFromRequest('drive');
        $this->form->page_size = ParamUtils::getFromRequest('page_size');

        $brands = DBUtils::select('car', null, '@brand', [
                    'ORDER' => 'brand'
        ]);

//        print_r($brands);
//        print_r($this->form->brand);
        App::getSmarty()->assign('brands', $brands);
        App::getSmarty()->assign('orders', $this->orders);

        $this->search_params = DBUtils::prepareParam($this->form->brand, 'brand', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->model, 'model[~]', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->type, 'transmission_type', $this->search_params);
        $this->search_params = DBUtils::prepareParam($this->form->drive, 'drive', $this->search_params);
        $this->search_params = DBUtils::prepareParam(1, 'rentable', $this->search_params);

        $where = DBUtils::prepareWhere($this->search_params, $this->form->order, ['brand', 'model']);

        $numOfRecords = DBUtils::count('car', [
                    '[><]car_price' => 'id_car_price'
                        ], '*', $where);
        $where['LIMIT'] = DBUtils::preparePagination($numOfRecords, $this->form->page_size);

        $this->records = DBUtils::select('car', [
                    '[><]car_price' => 'id_car_price'
                        ], [
                    'car.id_car',
                    'car.brand',
                    'car.model',
                    'car.eng_displacement',
                    'car.eng_info',
                    'car.eng_power',
                    'car.eng_torque',
                    'car.time_100',
                    'car.top_speed',
                    'car.transmission_type',
                    'car.drive',
                    'car_price.price_deposit'
                        ], $where);

        App::getSmarty()->assign('pageRecords', count($this->records));

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
        App::getSmarty()->assign('page_title', 'Samochody');
        App::getSmarty()->assign('form_name', 'cars-form');
        App::getSmarty()->assign('form_action', 'carsList');
        App::getSmarty()->assign('form_table', 'cars-table');
        App::getSmarty()->assign('records', $this->records);
        $this->assignSmarty();
        return !App::getMessages()->isError();
    }

    public function processCar() {
        $this->form_rent->id_car = $this->v->validateFromCleanURL(1, [
            'required' => true,
        ]);

        if (!App::getMessages()->isError()) {
            $where['id_car'] = $this->form_rent->id_car;

            $brand = ParamUtils::getFromCleanURL(2);
            $model = ParamUtils::getFromCleanURL(3);

            $this->form_rent->rent_start = (new \DateTime('now', new \DateTimeZone('Europe/Warsaw')))->format('Y-m-d\TH:i');
            $this->form_rent->rent_end = (new \DateTime('+1 day', new \DateTimeZone('Europe/Warsaw')))->format('Y-m-d\TH:i');


            $this->records = DBUtils::get('car', [
                        '[><]car_price' => 'id_car_price'
                            ], [
                        'car.id_car',
                        'car.brand',
                        'car.model',
                        'car.eng_displacement',
                        'car.eng_info',
                        'car.eng_power',
                        'car.eng_torque',
                        'car.time_100',
                        'car.top_speed',
                        'car.transmission_type',
                        'car.drive',
                        'car.fuel_type',
                        'car.fuel_capacity',
                        'car.fuel_consumption',
                        'car.doors',
                        'car.seats',
                        'car.weight',
                        'car_price.price_deposit',
                        'car_price.price_no_deposit',
                        'car_price.km_limit',
                        'car_price.additional_km',
                        'car_price.deposit'
                            ], $where);

            if (empty($this->records)) {
                Utils::addErrorMessage('Brak pojazdu o podanym ID!');
                return false;
            }

            $this->records['brand_url'] = trim($this->records['brand']);
            $this->records['model_url'] = trim($this->records['model']);
            $this->records['brand_url'] = strtolower($this->records['brand_url']);
            $this->records['model_url'] = strtolower($this->records['model_url']);
            $this->records['brand_url'] = preg_replace('/\s+/', '-', $this->records['brand_url']);
            $this->records['model_url'] = preg_replace('/\s+/', '-', $this->records['model_url']);

            if ($brand !== $this->records['brand_url'] || $model !== $this->records['model_url']) {
                App::getRouter()->redirectTo("car/{$this->form_rent->id_car}/{$this->records['brand_url']}/{$this->records['model_url']}");
            }

            App::getSmarty()->assign('form', $this->form_rent);
            App::getSmarty()->assign('page_title', "{$this->records['brand']}  {$this->records['model']}");
            App::getSmarty()->assign('car', $this->records);
            $this->assignSmarty();
        }

        return !App::getMessages()->isError();
    }

    public function action_cars() {
        if ($this->processCars()) {
            App::getSmarty()->display('CarsListView.tpl');
        } else {
            SessionUtils::storeMessages();
            App::getRouter()->redirectTo('main');
        }
    }

    public function action_carsList() {
        if ($this->processCars()) {
            App::getSmarty()->display('CarsListTable.tpl');
        } else {
            SessionUtils::storeMessages();
            App::getRouter()->redirectTo('main');
        }
    }

    public function action_car() {
        if ($this->processCar()) {
            App::getSmarty()->display('CarView.tpl');
        } else {
            SessionUtils::storeMessages();
            App::getRouter()->redirectTo('main');
        }
    }

    public function assignSmarty() {
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
    }

}
