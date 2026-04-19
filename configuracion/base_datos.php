<?php

return [
    'host' => $_ENV['DB_HOST'] ?? 'localhost',
    'puerto' => $_ENV['DB_PUERTO'] ?? '3306',
    'nombre' => $_ENV['DB_NOMBRE'] ?? 'pvsport',
    'usuario' => $_ENV['DB_USUARIO'] ?? 'root',
    'password' => $_ENV['DB_PASSWORD'] ?? '',
    'charset' => $_ENV['DB_CHARSET'] ?? 'utf8mb4',
    'socket' => $_ENV['DB_SOCKET'] ?? '',
];
