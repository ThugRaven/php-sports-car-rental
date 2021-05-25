<?php

use core\App;
use core\Utils;

App::getRouter()->setDefaultRoute('main'); #default action
App::getRouter()->setLoginRoute('login'); #action to forward if no permissions

Utils::addRoute('main', 'MainCtrl');

Utils::addRoute('account', 'AccountCtrl');
Utils::addRoute('accountEdit', 'AccountCtrl');
Utils::addRoute('accountSave', 'AccountCtrl');

Utils::addRoute('login', 'LoginCtrl');
Utils::addRoute('logout', 'LoginCtrl');

Utils::addRoute('registration', 'RegisterCtrl');
Utils::addRoute('register', 'RegisterCtrl');

Utils::addRoute('cars', 'CarsCtrl');
Utils::addRoute('car', 'CarsCtrl');

Utils::addRoute('rent', 'RentCtrl', ['customer','employee','admin']);

//Utils::addRoute('dashboard', 'DashboardCtrl');
