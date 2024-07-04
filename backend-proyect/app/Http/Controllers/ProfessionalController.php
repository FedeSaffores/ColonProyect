<?php

namespace App\Http\Controllers;

use App\Models\Professional;
use Illuminate\Http\Request;


class ProfessionalController extends Controller
{
    //
    public function index()
    {
   
        $professionals = Professional::with('user')->get();
        return response()->json($professionals);
    }
}
