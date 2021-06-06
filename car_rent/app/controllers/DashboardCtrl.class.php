<?php

namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\RoleUtils;
use core\SessionUtils;
use app\transfer\User;
use app\forms\CarsForm;

class DashboardCtrl {

    private $form;
    private $records;
    private $search_params;
    private $orders;

    public function __construct() {
        $this->form = new CarsForm();
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

    public function processDashboard() {
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

    public function action_dashboard() {
//        if ($this->processDashboard()) {
        App::getSmarty()->display('DashboardView.tpl');
//        } else {
//            App::getRouter()->redirectTo('main');
//        }
    }

    public function assignSmarty() {
        App::getSmarty()->assign('form', $this->form);
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
        App::getSmarty()->assign('records', $this->records);
    }

}
