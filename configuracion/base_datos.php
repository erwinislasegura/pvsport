<?php

return [
    'host' => $_ENV['DB_HOST'] ?? 'localhost',
    'puerto' => $_ENV['DB_PUERTO'] ?? '3306',
    'nombre' => $_ENV['DB_NOMBRE'] ?? 'gocreative_web_pvsport',
    'usuario' => $_ENV['DB_USUARIO'] ?? 'gocreative_eisla_web',
    'password' => $_ENV['DB_PASSWORD'] ?? 'Eisla1245.$',
    'charset' => $_ENV['DB_CHARSET'] ?? 'utf8mb4',
    'socket' => $_ENV['DB_SOCKET'] ?? '',
];
