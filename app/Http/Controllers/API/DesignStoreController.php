<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DesignStoreController extends Controller
{
    public function checkUser()
    {
        $sql = DB::select("
                    select * from admins_table
                ");

        return $sql;
    }
}
