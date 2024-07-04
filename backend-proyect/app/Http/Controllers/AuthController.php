<?php
namespace App\Http\Controllers;
use Illuminate\Support\Facades\Log;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use App\Models\Professional;
use Illuminate\Support\Facades\Auth;
use Illuminate\Auth\AuthenticationException;
use Laravel\Sanctum\HasApiTokens;



class AuthController extends Controller
{
    use HasApiTokens;

    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);
        
        $token = $user->createToken('AuthToken')->plainTextToken;
        return response()->json(['user' => $user, 'token' => $token], 201);
    }

    public function registerProfessional(Request $request) 
    {  
        try{
        $data = $request->all();
        
        $userValidator = Validator::make($data['user'],[
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
        ]);

        $professionalValidator = Validator::make($data['professional'],[
            'address' => 'nullable|string',
            'profession' => 'nullable|string',
            'years_of_experience' => 'nullable|integer',

        ]);
        $profilePictureValidator = Validator::make($data, [
            'profilePicture' => 'nullable|string',
        ]);

    
       
        if($userValidator->fails() || $professionalValidator->fails() || $profilePictureValidator->fails())
        { 
        return response()->json([
            'user_errors' => $userValidator->errors(),
            'professional_errors' => $professionalValidator->errors(),
            'profile_picture_errors' => $profilePictureValidator->errors(),
        ], 400);
        }
       
        $user = User::create([
            'name' => $data['user']['name'],
            'email' => $data['user']['email'],
            'password' => Hash::make($data['user']['password']),
        ]);

        $token = $user->createToken('AuthToken')->plainTextToken;

        $professional =  Professional::create([
            'user_id' => $user->id,
            'profile_picture' => $data['profilePicture'],
            'address' => $data['professional']['address'],
            'profession' => $data['professional']['profession'],
            'years_of_experience' => $data['professional']['yearsOfExperience'],
        ]);
        return response()->json(['user' => $user, 'professional' => $professional, 'token' => $token], 201);
    }catch (\Exception $e) {
        Log::error('Error al registrar el profesional:', [
            'message' => $e->getMessage(),
            'trace' => $e->getTraceAsString(),
        ]);

        return response()->json(['error' => 'Error interno del servidor'], 500);
    }
}

    public function login(Request $request)
    {
        try {
            $credentials = $request->validate([
                'email' => 'required|string|email',
                'password' => 'required|string',
            ]);
    
            if (Auth::attempt($credentials)) {
                $token = $request->user()->createToken('AuthToken')->plainTextToken;
    
                return response()->json(['token' => $token]);
            }
                throw new AuthenticationException('Invalid credentials');
            } catch (\Throwable $exception) {
            return response()->json(['message' => $exception->getMessage()], 401);
    }
    
    }
public function logout(Request $request) 
{
    $request->user()->currentAccessToken()->delete();

    return response()->json(['message' => 'Successfull logged out']);

}
}