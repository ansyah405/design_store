<?php

use App\Http\Controllers\API\DesignStoreController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/login', [DesignStoreController::class, 'checkUser'])->name('login');
