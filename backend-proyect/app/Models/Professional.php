<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Professional extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id', 
        'profile_picture', 
        'address', 
        'profession', 
        'years_of_experience'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
