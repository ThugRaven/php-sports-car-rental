<?php

namespace app\controllers;

use core\App;
use DateTime;

class DashboardMockCtrl {

    public function __construct() {
        
    }

    public function action_dashboardMock() {
        // Controls
        $hash = false;
        $enable = false;

        if (!$enable) {
            return false;
        }

        $rent_raw = file_get_contents(App::getConf()->app_url . '/mock_data/rent_mock_raw.json');
        $rent_raw = json_decode($rent_raw, true);
        $rent_sql = '';
        $user_raw = file_get_contents(App::getConf()->app_url . '/mock_data/user_mock_raw.json');
        $user_raw = json_decode($user_raw, true);
        $user_sql = '';

        // Create mock rent data
        $now = time();

        $records = App::getDB()->select('car', [
            '[><]car_price' => 'id_car_price'
                ], [
            'car.id_car' => [
                'car_price.price_deposit',
                'car_price.price_no_deposit',
                'car_price.km_limit',
                'car_price.additional_km'
            ]
        ]);

        for ($i = 0; $i < count($user_raw); $i++) {
            $user_raw[$i]['rents'] = 0;
            $user_raw[$i]['verified'] = 0;
        }

        for ($i = 0; $i < count($rent_raw); $i++) {
            // Clear rent_end
            $rent_raw[$i]['rent_end'] = substr($rent_raw[$i]['rent_end'], 0, 19);
           
            // Input id_rent_status
            $rent_start = new DateTime($rent_raw[$i]['rent_start']);
            $rent_start->format('Y-m-d H:i:s');
            $rent_end = new DateTime($rent_raw[$i]['rent_end']);
            $rent_end->format('Y-m-d H:i:s');

            if ($rent_end->getTimestamp() > $now) {
                $rent_raw[$i]['id_rent_status'] = 1; // Active
            } else {
                $rent_raw[$i]['id_rent_status'] = 2; // Completed
            }

            // Input distance and prices
            $diff = $rent_start->diff($rent_end);
            $days = $diff->days + 1;
            $randFloat = (rand() / getrandmax());
            $kilometers = round($records[$rent_raw[$i]['id_car']]['km_limit'] * ($randFloat < 0.1 ? 0.1 : $randFloat) * rand(1, 2));
            $rent_raw[$i]['distance'] = $kilometers * $days;
            $deposit = (rand(1, 10) > 5);
            $rent_raw[$i]['deposit'] = $deposit ? 1 : 0;
            $base_price = ($deposit ? $records[$rent_raw[$i]['id_car']]['price_deposit'] :
                    $records[$rent_raw[$i]['id_car']]['price_no_deposit']) * $days;
            $isOverLimit = (($records[$rent_raw[$i]['id_car']]['km_limit'] * $days) < $rent_raw[$i]['distance']);
            $over_km = $rent_raw[$i]['distance'] - ($records[$rent_raw[$i]['id_car']]['km_limit'] * $days);
            $rent_raw[$i]['total_price'] = $isOverLimit > 0 ? $base_price + ($over_km * $records[$rent_raw[$i]['id_car']]['additional_km']) : $base_price;

            // Input rents and verified user data
            $user_raw[$rent_raw[$i]['id_user'] - 1]['rents'] += 1;
            if ($user_raw[$rent_raw[$i]['id_user'] - 1]['rents'] >= 5) {
                $user_raw[$rent_raw[$i]['id_user'] - 1]['verified'] = 1;
            }

            $rent_sql .= "INSERT INTO `car_rent_db`.`rent` (`id_car`, `id_user`, `rent_start`, `rent_end`, `id_rent_status`, `distance`, `deposit`, `total_price`, `payment_type`, `create_time`) VALUES ({$rent_raw[$i]['id_car']}, {$rent_raw[$i]['id_user']}, '{$rent_raw[$i]['rent_start']}', '{$rent_raw[$i]['rent_end']}', {$rent_raw[$i]['id_rent_status']}, {$rent_raw[$i]['distance']}, {$rent_raw[$i]['deposit']}, {$rent_raw[$i]['total_price']}, '{$rent_raw[$i]['payment_type']}', '{$rent_raw[$i]['rent_start']}');\n";
        }

        // Create mock user data
        for ($i = 0; $i < count($user_raw); $i++) {
            if ($hash) {
                $user_raw[$i]['password'] = password_hash($user_raw[$i]['password'], PASSWORD_BCRYPT);
            }
            $user_sql .= "INSERT INTO `car_rent_db`.`user` (`login`, `password`, `email`, `id_user_role`, `name`, `surname`, `phone_number`, `rents`, `verified`, `birth_date`, `create_time`) VALUES ('{$user_raw[$i]['login']}', '{$user_raw[$i]['password']}', '{$user_raw[$i]['email']}', {$user_raw[$i]['id_user_role']}, '{$user_raw[$i]['name']}', '{$user_raw[$i]['surname']}', '{$user_raw[$i]['phone_number']}', {$user_raw[$i]['rents']}, {$user_raw[$i]['verified']}, '{$user_raw[$i]['birth_date']}', '{$user_raw[$i]['create_time']}');\n";
        }

        file_put_contents('mock_data/rent_sql.txt', $rent_sql);
        file_put_contents('mock_data/user_sql.txt', $user_sql);
        
        echo 'Done';
    }

}
