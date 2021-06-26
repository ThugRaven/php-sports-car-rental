<?php

namespace app\transfer;

class Rent {

    public $id_car;
    public $id_user;
    public $rent_start;
    public $rent_end;
    public $rent_diff;
    public $deposit;
    public $total_price;
    public $payment_type;

    public function __construct($id_car, $id_user, $rent_start, $rent_end, $rent_diff, $deposit, $total_price, $payment_type) {
        $this->id_car = $id_car;
        $this->id_user = $id_user;
        $this->rent_start = $rent_start;
        $this->rent_end = $rent_end;
        $this->rent_diff = $rent_diff;
        $this->deposit = $deposit;
        $this->total_price = $total_price;
        $this->payment_type = $payment_type;
    }

}
