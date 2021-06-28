<?php

namespace app\controllers;

use core\App;
use core\SessionUtils;
use core\DBUtils;
use core\ParamUtils;

class MainCtrl {

    private $records;

    public function processMain() {
        $car_index = ParamUtils::getFromCleanURL(1);
        if (!isset($car_index)) {
            $car_index = 1;
        }

        $this->records = DBUtils::select('car', [
                    '[><]car_price' => 'id_car_price'
                        ], [
                    'car.id_car',
                    'car.brand',
                    'car.model',
                    'car.eng_info',
                    'car.eng_power',
                    'car.eng_torque',
                    'car.top_speed',
                    'car_price.price_deposit'
                        ], [
                    'main_page[>]' => 0,
                    'ORDER' => 'main_page'
        ]);

        if ($car_index > count($this->records) || $car_index < 1) {
            $car_index = 1;
        }

        for ($i = 0; $i < count($this->records); $i++) {
            $this->records[$i]['brand_url'] = trim($this->records[$i]['brand']);
            $this->records[$i]['model_url'] = trim($this->records[$i]['model']);
            $this->records[$i]['brand_url'] = strtolower($this->records[$i]['brand_url']);
            $this->records[$i]['model_url'] = strtolower($this->records[$i]['model_url']);
            $this->records[$i]['brand_url'] = preg_replace('/\s+/', '-', $this->records[$i]['brand_url']);
            $this->records[$i]['model_url'] = preg_replace('/\s+/', '-', $this->records[$i]['model_url']);
        }

        $car = $this->records[$car_index - 1];

        App::getSmarty()->assign('records', $this->records);
        App::getSmarty()->assign('car', $car);
        App::getSmarty()->assign('car_index', $car_index);
        App::getSmarty()->assign('cars', count($this->records));
        App::getSmarty()->assign('user', SessionUtils::loadObject('user', true));
        return !App::getMessages()->isError();
    }

    public function action_main() {
        $this->processMain();
        App::getSmarty()->display('MainView.tpl');
    }

    public function action_mainContent() {
        if ($this->processMain()) {
            App::getSmarty()->display('MainViewContent.tpl');
        } else {
            App::getRouter()->redirectTo('main');
        }
    }

}
