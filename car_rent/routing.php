<?php

use core\App;
use core\Utils;

App::getRouter()->setDefaultRoute('main'); #default action
App::getRouter()->setLoginRoute('login'); #action to forward if no permissions

Utils::addRoute('main', 'MainCtrl');

//Utils::addRoute('user', 'UserCtrl');
//Utils::addRoute('userEdit', 'UserEditCtrl');

Utils::addRoute('login', 'LoginCtrl');
Utils::addRoute('logout', 'LoginCtrl');

Utils::addRoute('registration', 'RegisterCtrl');
Utils::addRoute('register', 'RegisterCtrl');

//Utils::addRoute('cars', 'CarListCtrl');
//Utils::addRoute('carDetails', 'CarDetailsCtrl');

//Utils::addRoute('rent', 'RentCtrl');

//Utils::addRoute('dashboard', 'DashboardCtrl');
