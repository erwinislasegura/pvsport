-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 19-04-2026 a las 16:17:00
-- Versión del servidor: 8.0.45-cll-lve
-- Versión de PHP: 8.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `vextra_erpcotiza`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ajustes_inventario`
--

CREATE TABLE `ajustes_inventario` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `tipo_ajuste` enum('entrada','salida') COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` decimal(12,2) NOT NULL,
  `motivo` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observacion` text COLLATE utf8mb4_unicode_ci,
  `usuario_id` bigint UNSIGNED DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ajustes_inventario`
--

INSERT INTO `ajustes_inventario` (`id`, `empresa_id`, `producto_id`, `tipo_ajuste`, `cantidad`, `motivo`, `observacion`, `usuario_id`, `fecha_creacion`) VALUES
(1, 69, 3, 'salida', 2.00, 'danio', 'Monitor con pantalla quebrada detectado durante el movimiento de estanterías.', 70, '2026-04-08 15:01:42'),
(2, 69, 4, 'entrada', 2.00, 'diferencia_conteo', 'Unidades encontradas en bodega que no estaban ingresadas en el sistema tras inventario físico.', 70, '2026-04-08 15:02:12'),
(3, 69, 5, 'entrada', 1.00, 'devolucion', '', 70, '2026-04-08 15:33:04'),
(4, 69, 1, 'salida', 1.00, 'merma', 'Equipo retirado del inventario para ser utilizado como unidad de demostración (Demo) en el mesón de atención a clientes. No apto para la venta posterior.', 70, '2026-04-08 15:39:36'),
(5, 73, 8, 'entrada', 100.00, 'correccion_inventario', '', 74, '2026-04-11 11:39:37'),
(6, 73, 9, 'entrada', 25.00, 'correccion_inventario', '', 74, '2026-04-11 11:52:03'),
(7, 73, 8, 'salida', 20.00, 'correccion_inventario', '', 74, '2026-04-11 11:53:53'),
(8, 73, 12, 'entrada', 20.00, 'correccion_inventario', '', 74, '2026-04-11 13:27:22'),
(9, 73, 13, 'entrada', 20.00, 'correccion_inventario', '', 74, '2026-04-11 14:31:46'),
(10, 73, 13, 'salida', 20.00, 'correccion_inventario', '', 74, '2026-04-11 14:36:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aperturas_caja_pos`
--

CREATE TABLE `aperturas_caja_pos` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `caja_id` bigint UNSIGNED NOT NULL,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `monto_inicial` decimal(12,2) NOT NULL DEFAULT '0.00',
  `observacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_apertura` datetime NOT NULL,
  `estado` enum('abierta','cerrada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'abierta'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `aperturas_caja_pos`
--

INSERT INTO `aperturas_caja_pos` (`id`, `empresa_id`, `caja_id`, `usuario_id`, `monto_inicial`, `observacion`, `fecha_apertura`, `estado`) VALUES
(1, 69, 1, 70, 100000.00, '', '2026-04-08 15:51:13', 'cerrada'),
(2, 69, 1, 70, 150000.00, '', '2026-04-09 21:29:50', 'abierta'),
(3, 73, 2, 74, 15000.00, '', '2026-04-11 11:55:13', 'cerrada'),
(4, 73, 3, 74, 20000.00, '', '2026-04-11 13:33:52', 'cerrada'),
(5, 73, 4, 74, 15000.00, '', '2026-04-11 18:16:51', 'abierta'),
(8, 69, 1, 1, 10000.00, 'Prueba lista escalonada', '2026-04-13 00:47:59', 'cerrada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aprobaciones_cotizacion`
--

CREATE TABLE `aprobaciones_cotizacion` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `cotizacion_id` bigint UNSIGNED DEFAULT NULL,
  `monto` decimal(12,2) NOT NULL DEFAULT '0.00',
  `motivo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `solicitante` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aprobador` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('pendiente','aprobada','rechazada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `fecha_aprobacion` date DEFAULT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `aprobaciones_cotizacion`
--

INSERT INTO `aprobaciones_cotizacion` (`id`, `empresa_id`, `cotizacion_id`, `monto`, `motivo`, `solicitante`, `aprobador`, `estado`, `fecha_aprobacion`, `observaciones`, `fecha_creacion`) VALUES
(1, 69, 1, 3784200.00, 'Aprobación desde enlace público', 'Juan Pérez', 'Cliente (portal público)', 'aprobada', '2026-04-10', 'Cliente aprobó desde enlace público con firma digital.', '2026-04-10 00:08:42'),
(2, 73, 6, 127925.00, '', 'sole', '', 'aprobada', '2026-04-11', '', '2026-04-11 11:13:57'),
(3, 73, 6, 127925.00, '', 'sole', '', 'aprobada', '2026-04-11', '', '2026-04-11 11:14:11'),
(4, 73, 7, 192780.00, 'Aprobación desde enlace público', 'encargada de compras', 'Cliente (portal público)', 'aprobada', '2026-04-11', 'Cliente aprobó desde enlace público con firma digital.', '2026-04-11 11:22:14'),
(5, 73, 8, 42840.00, 'Aprobación desde enlace público', 'encarga de compras', 'Cliente (portal público)', 'aprobada', '2026-04-11', 'Cliente aprobó desde enlace público con firma digital.', '2026-04-11 12:39:49'),
(6, 73, 9, 76160.00, 'Aprobación desde enlace público', 'encarga de compras', 'Cliente (portal público)', 'aprobada', '2026-04-11', 'Cliente aprobó desde enlace público con firma digital.', '2026-04-11 12:42:57'),
(7, 73, 9, 76160.00, 'Rechazo desde enlace público', 'Cliente Prueba cuatro', 'Cliente (portal público)', 'rechazada', '2026-04-11', 'Cliente rechazó desde enlace público.', '2026-04-11 12:43:47'),
(8, 73, 10, 156366.00, 'Aprobación desde enlace público', 'encargada de compras', 'Cliente (portal público)', 'aprobada', '2026-04-11', 'Cliente aprobó desde enlace público con firma digital.', '2026-04-11 13:35:45'),
(9, 73, 11, 134946.00, 'Rechazo desde enlace público', 'Razon Social Prueba cinco', 'Cliente (portal público)', 'rechazada', '2026-04-11', 'Cliente rechazó desde enlace público.', '2026-04-11 13:54:41'),
(13, 69, 15, 10362817.50, 'Aprobación desde enlace público', 'Pablo Rivas', 'Cliente (portal público)', 'aprobada', '2026-04-12', 'Cliente aprobó desde enlace público con firma digital.', '2026-04-12 22:22:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajas_pos`
--

CREATE TABLE `cajas_pos` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` enum('activa','inactiva') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activa',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cajas_pos`
--

INSERT INTO `cajas_pos` (`id`, `empresa_id`, `nombre`, `codigo`, `estado`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 69, 'Caja Principal', 'CP-001', 'activa', '2026-04-08 15:47:49', NULL),
(2, 73, 'caja sole', '0121', 'activa', '2026-04-11 11:54:57', NULL),
(3, 73, 'sole prueba cuatro', '456', 'activa', '2026-04-11 13:22:27', NULL),
(4, 73, 'caja prueba seis', '0001', 'activa', '2026-04-11 14:42:14', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_compras`
--

CREATE TABLE `catalogo_compras` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `flow_token` varchar(160) COLLATE utf8mb3_unicode_ci NOT NULL,
  `commerce_order` varchar(120) COLLATE utf8mb3_unicode_ci NOT NULL,
  `estado_pago` enum('pendiente','aprobado','rechazado','anulado') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pendiente',
  `estado_envio` enum('pendiente','preparando','enviado','entregado','cancelado') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pendiente',
  `comprador_nombre` varchar(160) COLLATE utf8mb3_unicode_ci NOT NULL,
  `comprador_correo` varchar(150) COLLATE utf8mb3_unicode_ci NOT NULL,
  `comprador_telefono` varchar(80) COLLATE utf8mb3_unicode_ci NOT NULL,
  `comprador_documento` varchar(80) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `comprador_empresa` varchar(180) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `envio_metodo` enum('starken','blue_express','chile_express') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'starken',
  `envio_direccion` varchar(220) COLLATE utf8mb3_unicode_ci NOT NULL,
  `envio_referencia` varchar(220) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `envio_comuna` varchar(120) COLLATE utf8mb3_unicode_ci NOT NULL,
  `envio_ciudad` varchar(120) COLLATE utf8mb3_unicode_ci NOT NULL,
  `envio_region` varchar(120) COLLATE utf8mb3_unicode_ci NOT NULL,
  `total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `moneda` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'CLP',
  `payload_flow` json DEFAULT NULL,
  `fecha_confirmacion_pago` datetime DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `catalogo_compras`
--

INSERT INTO `catalogo_compras` (`id`, `empresa_id`, `flow_token`, `commerce_order`, `estado_pago`, `estado_envio`, `comprador_nombre`, `comprador_correo`, `comprador_telefono`, `comprador_documento`, `comprador_empresa`, `envio_metodo`, `envio_direccion`, `envio_referencia`, `envio_comuna`, `envio_ciudad`, `envio_region`, `total`, `moneda`, `payload_flow`, `fecha_confirmacion_pago`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 77, '0AF1FA46EB7B822B25EB3F0EDEB808B0A8BE92AD', 'CAT-77-711E6D9469', 'pendiente', 'pendiente', 'Vicente Isla Mella', 'vicente.isla13@gmail.com', '+56966938730', '25132179-5', NULL, 'starken', 'Parma 1310', 'envio por pagar', 'Los Angeles', 'Los Angeles', 'Bio Bio', 500.00, 'CLP', '{\"url\": \"https://www.flow.cl/app/web/pay.php\", \"token\": \"0AF1FA46EB7B822B25EB3F0EDEB808B0A8BE92AD\", \"flowOrder\": 166285475}', NULL, '2026-04-15 14:57:23', NULL),
(2, 77, '32176B4C0667A1A5F64BBBFAC2CF487FB494C11V', 'CAT-77-5FB801E254', 'aprobado', 'pendiente', 'Vicente Isla Mella', 'vicente.isla13@gmail.com', '+56966938730', '25132179-5', NULL, 'starken', 'Parma 1310', 'envio por pagar', 'Los Angeles', 'Los Angeles', 'Bio Bio', 500.00, 'CLP', '{\"payer\": \"vicente.isla13@gmail.com\", \"amount\": \"500\", \"status\": 2, \"subject\": \"Compra catálogo Pv SportChile\", \"currency\": \"CLP\", \"optional\": null, \"flowOrder\": 166286333, \"merchantId\": null, \"paymentData\": {\"fee\": \"16.00\", \"date\": \"2026-04-15 15:06:45\", \"media\": \"Mach\", \"taxes\": 3, \"amount\": \"500.00\", \"balance\": 481, \"currency\": \"CLP\", \"transferDate\": \"2026-04-16 00:00:00\", \"conversionDate\": null, \"conversionRate\": null}, \"requestDate\": \"2026-04-15 15:06:14\", \"pending_info\": {\"date\": null, \"media\": null}, \"commerceOrder\": \"CAT-77-5FB801E254\"}', '2026-04-15 15:06:48', '2026-04-15 15:06:14', '2026-04-15 15:06:48'),
(3, 77, 'F578CE0A71B8ABF73161EF5587F26EE0462B181Z', 'CAT-77-CB5EC755E5', 'aprobado', 'pendiente', 'Vicente Isla Mella', 'vicente.isla13@gmail.com', '+56966938730', '25132179-5', NULL, 'starken', 'Parma 1310', 'envio por pagar', 'Los Angeles', 'Los Angeles', 'Bio Bio', 500.00, 'CLP', '{\"payer\": \"vicente.isla13@gmail.com\", \"amount\": \"500\", \"status\": 2, \"subject\": \"Compra catálogo Pv SportChile\", \"currency\": \"CLP\", \"optional\": null, \"flowOrder\": 166287909, \"merchantId\": null, \"paymentData\": {\"fee\": \"16.00\", \"date\": \"2026-04-15 15:24:42\", \"media\": \"Mach\", \"taxes\": 3, \"amount\": \"500.00\", \"balance\": 481, \"currency\": \"CLP\", \"transferDate\": \"2026-04-16 00:00:00\", \"conversionDate\": null, \"conversionRate\": null}, \"requestDate\": \"2026-04-15 15:23:58\", \"pending_info\": {\"date\": null, \"media\": null}, \"commerceOrder\": \"CAT-77-CB5EC755E5\"}', '2026-04-15 15:24:48', '2026-04-15 15:23:58', '2026-04-15 15:24:48'),
(4, 77, '11C09F708E5358CE2B8CB9D83FA4BE84CA982C6E', 'CAT-77-05182B1FC4', 'pendiente', 'pendiente', 'Vicente Isla Mella', 'vicente.isla13@gmail.com', '+56966938730', '25132179-5', NULL, 'starken', 'Parma 1310', 'envio por pagar', 'Los Angeles', 'Los Angeles', 'Bio Bio', 63000.00, 'CLP', '{\"url\": \"https://www.flow.cl/app/web/pay.php\", \"token\": \"11C09F708E5358CE2B8CB9D83FA4BE84CA982C6E\", \"flowOrder\": 166289382}', NULL, '2026-04-15 15:41:04', NULL),
(5, 77, '7C30F1D1741C876EB6F58F550DFC71335F3E86AR', 'CAT-77-62AA292E29', 'pendiente', 'pendiente', 'Vicente Isla Mella', 'vicente.isla13@gmail.com', '+56966938730', '25132179-5', NULL, 'starken', 'Parma 1310', 'envio por pagar', 'Los Angeles', 'Los Angeles', 'Bio Bio', 3000.00, 'CLP', '{\"url\": \"https://www.flow.cl/app/web/pay.php\", \"token\": \"7C30F1D1741C876EB6F58F550DFC71335F3E86AR\", \"flowOrder\": 166291397}', NULL, '2026-04-15 15:54:06', NULL),
(6, 77, 'BDD42E62DF8DA87EEC1C3EA7BFCBE02E55F794CI', 'CAT-77-409B3C4D32', 'aprobado', 'pendiente', 'Vicente Isla Mella', 'vicente.isla13@gmail.com', '+56966938730', '25132179-5', NULL, 'starken', 'Parma 1310', 'envio por pagar', 'Los Angeles', 'Los Angeles', 'Bio Bio', 500.00, 'CLP', '{\"payer\": \"vicente.isla13@gmail.com\", \"amount\": \"500\", \"status\": 2, \"subject\": \"Compra catálogo Pv SportChile\", \"currency\": \"CLP\", \"optional\": null, \"flowOrder\": 166291787, \"merchantId\": null, \"paymentData\": {\"fee\": \"16.00\", \"date\": \"2026-04-15 15:57:26\", \"media\": \"Mach\", \"taxes\": 3, \"amount\": \"500.00\", \"balance\": 481, \"currency\": \"CLP\", \"transferDate\": \"2026-04-16 00:00:00\", \"conversionDate\": null, \"conversionRate\": null}, \"requestDate\": \"2026-04-15 15:57:00\", \"pending_info\": {\"date\": null, \"media\": null}, \"commerceOrder\": \"CAT-77-409B3C4D32\"}', '2026-04-15 15:57:32', '2026-04-15 15:57:00', '2026-04-15 15:57:32'),
(7, 77, 'EC0F3BE256BEEBD88CA2AA009DE0216F47B85CBC', 'CAT-77-6B25CEA4A1', 'aprobado', 'pendiente', 'Vicente Isla Mella', 'vicente.isla13@gmail.com', '+56966938730', '25132179-5', NULL, 'starken', 'Parma 1310', 'envio por pagar', 'Los Angeles', 'Los Angeles', 'Bio Bio', 500.00, 'CLP', '{\"payer\": \"vicente.isla13@gmail.com\", \"amount\": \"500\", \"status\": 2, \"subject\": \"Compra catálogo Pv SportChile\", \"currency\": \"CLP\", \"optional\": null, \"flowOrder\": 166293053, \"merchantId\": null, \"paymentData\": {\"fee\": \"16.00\", \"date\": \"2026-04-15 16:07:43\", \"media\": \"Mach\", \"taxes\": 3, \"amount\": \"500.00\", \"balance\": 481, \"currency\": \"CLP\", \"transferDate\": \"2026-04-16 00:00:00\", \"conversionDate\": null, \"conversionRate\": null}, \"requestDate\": \"2026-04-15 16:06:57\", \"pending_info\": {\"date\": null, \"media\": null}, \"commerceOrder\": \"CAT-77-6B25CEA4A1\"}', '2026-04-15 16:07:47', '2026-04-15 16:06:57', '2026-04-15 16:07:47'),
(8, 77, '366BA514FBAF6D8E7FA4488EF9952C9EECFE097K', 'CAT-77-9BA71F0B27', 'aprobado', 'pendiente', 'Vicente Isla Mella', 'vicente.isla13@gmail.com', '+56966938730', '25132179-5', NULL, 'starken', 'Parma 1310', 'envio por pagar', 'Los Angeles', 'Los Angeles', 'Bio Bio', 500.00, 'CLP', '{\"payer\": \"vicente.isla13@gmail.com\", \"amount\": \"500\", \"status\": 2, \"subject\": \"Compra catálogo Pv SportChile\", \"currency\": \"CLP\", \"optional\": null, \"flowOrder\": 166455340, \"merchantId\": null, \"paymentData\": {\"fee\": \"16.00\", \"date\": \"2026-04-16 23:06:51\", \"media\": \"Mach\", \"taxes\": 3, \"amount\": \"500.00\", \"balance\": 481, \"currency\": \"CLP\", \"transferDate\": \"2026-04-17 00:00:00\", \"conversionDate\": null, \"conversionRate\": null}, \"requestDate\": \"2026-04-16 23:06:18\", \"pending_info\": {\"date\": null, \"media\": null}, \"commerceOrder\": \"CAT-77-9BA71F0B27\"}', '2026-04-16 23:06:56', '2026-04-16 23:06:18', '2026-04-16 23:06:56'),
(9, 77, '4638FDE626A2870304DBD947151F46ABA76E852D', 'CAT-77-65051E839F', 'pendiente', 'pendiente', 'Dnj', 'javieravalenzuela19@gmail.com', '995485847', '111111111', NULL, 'starken', 'Fed', NULL, 'Ddd', 'Ddd', 'Región Metropolitana de Santiago', 30000.00, 'CLP', '{\"url\": \"https://www.flow.cl/app/web/pay.php\", \"token\": \"4638FDE626A2870304DBD947151F46ABA76E852D\", \"flowOrder\": 166521627}', NULL, '2026-04-17 16:28:15', NULL),
(10, 77, 'AD85C9F1B438EA0CDDCB932DF90220B83A9D424F', 'CAT-77-FF0A495360', 'pendiente', 'pendiente', 'Loki Rexton 3 Negro', 'visla@pvsport.cl', '+56966938730', '111111111-1', NULL, 'starken', 'Parma 1310', 'envio por pagar', 'Los Angeles', 'Los Angeles', 'Bio Bio', 24999.99, 'CLP', '{\"url\": \"https://www.flow.cl/app/web/pay.php\", \"token\": \"AD85C9F1B438EA0CDDCB932DF90220B83A9D424F\", \"flowOrder\": 166525697}', NULL, '2026-04-17 17:02:18', NULL),
(11, 77, '607F5F444A3452671933CA418EBE9917BE878EAE', 'CAT-77-194EDAAB1B', 'pendiente', 'pendiente', 'Municipalidad', 'erwin.2785@gmail.com', '+56944627287', '15.626.773-2', 'Prueba', 'starken', 'Parma', NULL, 'Los Angeles', 'Santiago de Chile (Santiago, Chile)', 'Biobío', 27000.00, 'CLP', '{\"url\": \"https://www.flow.cl/app/web/pay.php\", \"token\": \"607F5F444A3452671933CA418EBE9917BE878EAE\", \"flowOrder\": 166595467}', NULL, '2026-04-18 14:10:27', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_compra_items`
--

CREATE TABLE `catalogo_compra_items` (
  `id` bigint UNSIGNED NOT NULL,
  `compra_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `producto_nombre` varchar(180) COLLATE utf8mb3_unicode_ci NOT NULL,
  `cantidad` int UNSIGNED NOT NULL,
  `precio_unitario` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `metadata` json DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `catalogo_compra_items`
--

INSERT INTO `catalogo_compra_items` (`id`, `compra_id`, `producto_id`, `producto_nombre`, `cantidad`, `precio_unitario`, `subtotal`, `metadata`, `fecha_creacion`) VALUES
(1, 1, 48, 'PRODUCTO DE PRUEBA', 1, 500.00, 500.00, '{\"id\": 48, \"nombre\": \"PRODUCTO DE PRUEBA\", \"precio\": 500, \"cantidad\": 1, \"subtotal\": 500}', '2026-04-15 14:57:23'),
(2, 2, 48, 'PRODUCTO DE PRUEBA', 1, 500.00, 500.00, '{\"id\": 48, \"nombre\": \"PRODUCTO DE PRUEBA\", \"precio\": 500, \"cantidad\": 1, \"subtotal\": 500}', '2026-04-15 15:06:14'),
(3, 3, 48, 'PRODUCTO DE PRUEBA', 1, 500.00, 500.00, '{\"id\": 48, \"nombre\": \"PRODUCTO DE PRUEBA\", \"precio\": 500, \"cantidad\": 1, \"subtotal\": 500}', '2026-04-15 15:23:58'),
(4, 4, 48, 'PRODUCTO DE PRUEBA', 1, 3000.00, 3000.00, '{\"id\": 48, \"nombre\": \"PRODUCTO DE PRUEBA\", \"precio\": 3000, \"cantidad\": 1, \"subtotal\": 3000}', '2026-04-15 15:41:04'),
(5, 4, 32, 'Acelerante Haifu', 1, 30000.00, 30000.00, '{\"id\": 32, \"nombre\": \"Acelerante Haifu\", \"precio\": 30000, \"cantidad\": 1, \"subtotal\": 30000}', '2026-04-15 15:41:04'),
(6, 4, 21, 'Reactor Tornado V5 40+ Rojo', 1, 13000.00, 13000.00, '{\"id\": 21, \"nombre\": \"Reactor Tornado V5 40+ Rojo\", \"precio\": 13000, \"cantidad\": 1, \"subtotal\": 13000}', '2026-04-15 15:41:04'),
(7, 4, 33, 'Madero Loki Kirin K2', 1, 17000.00, 17000.00, '{\"id\": 33, \"nombre\": \"Madero Loki Kirin K2\", \"precio\": 17000, \"cantidad\": 1, \"subtotal\": 17000}', '2026-04-15 15:41:04'),
(8, 5, 48, 'PRODUCTO DE PRUEBA', 1, 3000.00, 3000.00, '{\"id\": 48, \"nombre\": \"PRODUCTO DE PRUEBA\", \"precio\": 3000, \"cantidad\": 1, \"subtotal\": 3000}', '2026-04-15 15:54:06'),
(9, 6, 48, 'PRODUCTO DE PRUEBA', 1, 500.00, 500.00, '{\"id\": 48, \"nombre\": \"PRODUCTO DE PRUEBA\", \"precio\": 500, \"cantidad\": 1, \"subtotal\": 500}', '2026-04-15 15:57:00'),
(10, 7, 48, 'PRODUCTO DE PRUEBA', 1, 500.00, 500.00, '{\"id\": 48, \"imagen\": \"/catalogo/77/producto/48/imagen\", \"nombre\": \"PRODUCTO DE PRUEBA\", \"precio\": 500, \"cantidad\": 1, \"subtotal\": 500, \"descripcion\": \"PRODUCTO DE PRUEBA\"}', '2026-04-15 16:06:57'),
(11, 8, 70, 'Loki Arthur Green', 1, 500.00, 500.00, '{\"id\": 70, \"imagen\": \"https://vextra.cl/catalogo/77/producto/70/imagen\", \"nombre\": \"Loki Arthur Green\", \"precio\": 500, \"cantidad\": 1, \"subtotal\": 500, \"descripcion\": \"Estás en nivel principiante avanzado o intermedio Juegas con loops, control y colocación Quieres una goma cómoda para revés o derecho controlado\", \"proximo_catalogo\": 1, \"proximo_dias_catalogo\": 11}', '2026-04-16 23:06:18'),
(12, 9, 32, 'Acelerante Haifu', 1, 30000.00, 30000.00, '{\"id\": 32, \"imagen\": \"http://vextra.cl/catalogo/77/producto/32/imagen\", \"nombre\": \"Acelerante Haifu\", \"precio\": 30000, \"cantidad\": 1, \"subtotal\": 30000, \"descripcion\": \"Aumenta la velocidad La pelota sale más rápida y con mayor potencia. Mejora el efecto (spin) Permite generar topspin más pesado y con mejor curva. Más efecto catapulta La goma se siente más “viva”, como si tuviera resorte. Mayor sensación (feeling) Mejor contacto con la pelota, ideal para jugadores técnicos.\", \"proximo_catalogo\": 0, \"proximo_dias_catalogo\": 8}', '2026-04-17 16:28:15'),
(13, 10, 32, 'Acelerante Haifu', 1, 24999.99, 24999.99, '{\"id\": 32, \"imagen\": \"https://vextra.cl/catalogo/77/producto/32/imagen\", \"nombre\": \"Acelerante Haifu\", \"precio\": 24999.99, \"cantidad\": 1, \"subtotal\": 24999.99, \"descripcion\": \"Aumenta la velocidad La pelota sale más rápida y con mayor potencia. Mejora el efecto (spin) Permite generar topspin más pesado y con mejor curva. Más efecto catapulta La goma se siente más “viva”, como si tuviera resorte. Mayor sensación (feeling) Mejor contacto con la pelota, ideal para jugadores técnicos.\", \"precio_base\": 30000, \"proximo_catalogo\": 0, \"proximo_dias_catalogo\": 8}', '2026-04-17 17:02:18'),
(14, 11, 73, 'Loki Kirin K9', 1, 27000.00, 27000.00, '{\"id\": 73, \"imagen\": \"https://vextra.cl/catalogo/77/producto/73/imagen\", \"nombre\": \"Loki Kirin K9\", \"precio\": 27000, \"cantidad\": 1, \"subtotal\": 27000, \"descripcion\": \"Alta velocidad: ideal para ataques y topspin agresivo Buen control para su categoría: no es salvaje, pero exige técnica Sensación firme: golpe más directo y potente Respuesta explosiva: la pelota sale con decisión\", \"precio_base\": 27000, \"proximo_catalogo\": 1, \"proximo_dias_catalogo\": 10}', '2026-04-18 14:10:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_productos`
--

CREATE TABLE `categorias_productos` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('activo','inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias_productos`
--

INSERT INTO `categorias_productos` (`id`, `empresa_id`, `nombre`, `descripcion`, `estado`, `fecha_creacion`) VALUES
(1, 69, 'Computación y Portabilidad', 'Equipos de cómputo completos, incluyendo laptops de alto rendimiento, estaciones de trabajo (workstations) y tablets. Orientado a soluciones de movilidad y productividad de oficina.', 'activo', '2026-04-08 12:49:12'),
(2, 69, 'Componentes y Hardware Interno', 'Piezas fundamentales para el ensamble y actualización de computadores, tales como procesadores, tarjetas gráficas, memorias RAM y unidades de estado sólido (SSD).', 'activo', '2026-04-08 12:49:34'),
(3, 69, 'Periféricos', 'Dispositivos externos de interacción, incluyendo monitores de alta resolución, teclados mecánicos, mouses ergonómicos y accesorios diseñados para mejorar la experiencia de usuario.', 'activo', '2026-04-08 12:49:49'),
(4, 69, 'Infraestructura de Redes', 'Equipamiento para conectividad y transmisión de datos. Incluye routers de alta velocidad, switches administrables, puntos de acceso Wi-Fi 6 y soluciones de cableado estructurado.', 'activo', '2026-04-08 12:50:19'),
(5, 69, 'Almacenamiento y Respaldo', 'Dispositivos dedicados a la seguridad de la información, como servidores NAS, discos duros externos de alta capacidad y memorias flash de alta velocidad de transferencia.', 'activo', '2026-04-08 12:50:35'),
(6, 69, 'Soporte y Mantenimiento Técnico', 'Servicios profesionales de asistencia técnica, reparación de hardware y optimización de sistemas operativos para empresas y particulares.', 'activo', '2026-04-08 12:57:54'),
(7, 69, 'Consultoría e Infraestructura IT', 'Asesoría especializada en diseño de redes, seguridad de la información e implementación de soluciones en la nube.', 'activo', '2026-04-08 12:58:11'),
(8, 73, 'cuadernos', '', 'activo', '2026-04-11 10:29:29'),
(9, 73, 'cargador telefono', 'cargador rapido', 'activo', '2026-04-11 10:34:41'),
(10, 73, 'electronica', 'incluye todo tipo de cargadores', 'activo', '2026-04-11 10:35:47'),
(11, 73, 'cuadernos', 'cuadernos universitarios de niños', 'activo', '2026-04-11 10:36:08'),
(12, 73, 'sabanas 1 1/2', 'sabanas', 'activo', '2026-04-11 12:12:52'),
(13, 73, 'plumon de cama 2 plazas', 'plumo de cama 2 plazas ', 'activo', '2026-04-11 12:17:00'),
(14, 73, 'ropa de cama', 'plumon de cama', 'activo', '2026-04-11 12:19:55'),
(15, 73, 'ropa de niño', 'buzo de niño', 'activo', '2026-04-11 13:27:11'),
(25, 73, 'Mesa comedor', '', 'activo', '2026-04-14 00:16:04'),
(26, 77, 'Gomas', 'Gomas para maderos de tenis de mesa', 'activo', '2026-04-14 14:22:34'),
(27, 77, 'Maderos', 'Maderos para gomas de tenis mesa', 'activo', '2026-04-14 14:23:17'),
(28, 77, 'Estuches', 'Estuches para guardas paletas de tenis mesa', 'activo', '2026-04-14 14:23:50'),
(29, 77, 'Pelotas', 'Pelotas ABS 40+', 'activo', '2026-04-14 14:24:44'),
(30, 77, 'Poleras', 'Poleras deportivas', 'activo', '2026-04-14 14:28:11'),
(31, 77, 'Acelerantes', 'Acelerante para gomas de tenis de mesa', 'activo', '2026-04-14 14:28:49'),
(32, 77, 'Limpiadores', 'Limpiadores para gomas tenis de mesa', 'activo', '2026-04-14 14:29:58'),
(33, 77, 'Poros', 'Poros grandes → la pelota sale disparada, ideal para ataque\r\nPoros pequeños → más precisión, mejor para control y técnica', 'activo', '2026-04-18 13:19:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cierres_caja_pos`
--

CREATE TABLE `cierres_caja_pos` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `apertura_caja_id` bigint UNSIGNED NOT NULL,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `monto_esperado` decimal(12,2) NOT NULL,
  `monto_contado` decimal(12,2) NOT NULL,
  `diferencia` decimal(12,2) NOT NULL,
  `observacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_cierre` datetime NOT NULL,
  `monto_efectivo` decimal(12,2) NOT NULL DEFAULT '0.00',
  `monto_transferencia` decimal(12,2) NOT NULL DEFAULT '0.00',
  `monto_tarjeta` decimal(12,2) NOT NULL DEFAULT '0.00',
  `monto_inicial` decimal(12,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cierres_caja_pos`
--

INSERT INTO `cierres_caja_pos` (`id`, `empresa_id`, `apertura_caja_id`, `usuario_id`, `monto_esperado`, `monto_contado`, `diferencia`, `observacion`, `fecha_cierre`, `monto_efectivo`, `monto_transferencia`, `monto_tarjeta`, `monto_inicial`) VALUES
(1, 69, 1, 70, 2377350.00, 2377350.00, 0.00, '', '2026-04-09 21:29:37', 900000.00, 1300000.00, 77350.00, 100000.00),
(2, 73, 3, 74, 257125.00, 250000.00, -7125.00, 'diferencia por devolucion', '2026-04-11 13:33:34', 168000.00, 29155.00, 44970.00, 15000.00),
(3, 73, 4, 74, 70000.00, 70000.00, 0.00, '', '2026-04-11 14:41:40', 50000.00, 0.00, 0.00, 20000.00),
(4, 69, 8, 1, 10000.00, 10000.00, 0.00, '', '2026-04-13 00:50:33', 0.00, 0.00, 0.00, 10000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `razon_social` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_comercial` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identificador_fiscal` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `giro` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(220) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ciudad` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendedor_id` bigint UNSIGNED DEFAULT NULL,
  `notas` text COLLATE utf8mb4_unicode_ci,
  `estado` enum('activo','inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `empresa_id`, `nombre`, `razon_social`, `nombre_comercial`, `identificador_fiscal`, `giro`, `correo`, `telefono`, `direccion`, `ciudad`, `vendedor_id`, `notas`, `estado`, `fecha_creacion`, `fecha_actualizacion`, `fecha_eliminacion`) VALUES
(1, 69, 'Consumidor final', 'Venta rápida POS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'activo', '2026-04-08 15:52:55', NULL, NULL),
(2, 69, 'Municipalidad', 'Acquaperla SpA', 'Go Creative', '666666-6', 'ewasdfghj', 'erwin.2785@gmail.com', '+56944627287', 'Parma', 'Santiago de Chile (Santiago, Chile)', NULL, '', 'activo', '2026-04-09 00:21:51', NULL, '2026-04-09 00:21:59'),
(3, 69, 'María Soto', 'Minería del Cobre Atacama S.A.', 'Minera Atacama', '77.123.445-K', 'Extracción de minerales metalíferos no ferrosos', 'vextracl@gmail.com', '+56 9 6662 3344', 'Av. Industrial 4500, Antofagasta', 'Antofagasta', 1, '', 'activo', '2026-04-09 00:23:47', '2026-04-10 00:36:28', NULL),
(4, 69, 'Marcela Pedreros', 'Servicios Logísticos Santiago SpA', 'Logi-SCL', '77.009.882-K', 'Transporte de carga por carretera', 'contacto@logiscl.cl', '+56 9 2998 8776', 'Camino a Melipilla 980, Maipú', 'Santiago', 2, '', 'activo', '2026-04-09 00:36:09', '2026-04-09 00:40:02', NULL),
(5, 69, 'Felipe Carcamo', 'Agrícola y Ganadera del Sur Ltda.', 'AgroSur', '88.344.551-0', 'Cultivo de cereales', 'administracion@agrosur.cl', '+56 9 5656 3213', 'Ruta 5 Sur Km 10, Puerto Montt', 'Puerto Montt', 3, '', 'activo', '2026-04-09 00:37:22', '2026-04-12 22:22:41', NULL),
(6, 69, 'Gonzalo Freire', 'Comercializadora de Repuestos Maule SpA', 'Repuestos Maule', '76.991.002-3', 'Venta de partes y piezas', 'ventas@repuestosmaule.cl', '+56 9 4113 7890', 'Calle 1 Oriente 540, Talca', 'Talca', 4, '', 'activo', '2026-04-09 00:41:58', '2026-04-09 00:48:37', NULL),
(7, 73, 'Consumidor final', 'Venta rápida POS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'activo', '2026-04-11 11:58:20', NULL, NULL),
(8, 73, 'María', 'Cliente Prueba dos', 'Nombre Comercial Prueba dos', '22.222.222-2', 'Giro Prueba dos', 'soledadmellazuniga@gmail.com', '+56412123545', 'siena 4562', 'Los Angeles', NULL, '', 'activo', '2026-04-11 12:00:33', '2026-04-11 12:19:01', NULL),
(9, 73, 'contacto prueba cuatro', 'Cliente Prueba cuatro', 'Nombre Comercial Prueba cuatro', '33.333.333-3', 'Giro Prueba cuatro', 'soledadmellazuniga@gmail.com', '+5645122561313', 'Roma 123', 'Arica', 6, '', 'activo', '2026-04-11 13:35:16', '2026-04-11 13:35:32', NULL),
(10, 73, 'Nombre contacto prueba cinco', 'Razon Social Prueba cinco', 'Nombre comecial prueba cinco', '10.100.100-1', 'Giro Prueba Cinco', 'soledadmellazuniga@gmail.com', '+5645122561313', 'Roma 123', 'Arica', 6, '', 'activo', '2026-04-11 14:15:43', '2026-04-11 14:15:55', NULL),
(15, 69, 'Pablo Rivas D.', 'Universidad Tecnológica de la Frontera S.A.', 'UTFrontera', '71.556.000-7', 'Institución de Enseñanza Superior y Servicios de Investigación', 'javieraagonzalezmoeller@gmail.com', '+56 9 8900 3418', 'Av. Alemania 0450, Temuco', 'Temuco', 3, 'Cliente institucional con proceso de pago a 30 días mediante orden de compra. Requiere facturación electrónica detallada por departamento.', 'activo', '2026-04-12 23:15:22', '2026-04-13 00:48:22', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes_listas_precios`
--

CREATE TABLE `clientes_listas_precios` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `lista_precio_id` bigint UNSIGNED NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes_listas_precios`
--

INSERT INTO `clientes_listas_precios` (`id`, `empresa_id`, `cliente_id`, `lista_precio_id`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(2, 69, 4, 3, '2026-04-09 00:40:02', NULL),
(6, 69, 6, 3, '2026-04-09 00:48:38', NULL),
(11, 69, 3, 2, '2026-04-10 00:36:28', NULL),
(12, 73, 8, 4, '2026-04-11 12:19:01', NULL),
(16, 69, 15, 11, '2026-04-13 00:48:22', NULL),
(17, 69, 15, 2, '2026-04-13 00:48:22', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuraciones`
--

CREATE TABLE `configuraciones` (
  `id` bigint UNSIGNED NOT NULL,
  `clave` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor` text COLLATE utf8mb4_unicode_ci,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuraciones`
--

INSERT INTO `configuraciones` (`id`, `clave`, `valor`, `descripcion`, `fecha_actualizacion`) VALUES
(1, 'nombre_plataforma', 'CotizaPro', 'Nombre comercial de la plataforma', '2026-04-08 01:13:24'),
(2, 'correo_soporte', 'soporte@cotizapro.local', 'Correo principal de soporte', '2026-04-08 01:13:24'),
(3, 'dias_alerta_vencimiento', '7', 'Días previos para alertar vencimientos', '2026-04-07 01:34:34'),
(7, 'recaptcha_habilitado', '1', 'Activa o desactiva Google reCAPTCHA en formularios públicos (0/1)', '2026-04-08 01:13:24'),
(8, 'recaptcha_site_key', '6Ld16KosAAAAANcF8xDnmW0i2nAjKx9BxjteGCG8', 'Site key de Google reCAPTCHA para el frontend', '2026-04-08 01:13:24'),
(9, 'recaptcha_secret_key', '6Ld16KosAAAAAHGu4f5pLRKL13Xj30oyefTaBecD', 'Secret key de Google reCAPTCHA para validación backend', '2026-04-08 01:13:24'),
(12, 'moneda_defecto', 'CLP', NULL, '2026-04-08 01:13:24'),
(13, 'zona_horaria', 'America/Santiago', NULL, '2026-04-08 01:13:24'),
(14, 'estado_plataforma', 'activo', NULL, '2026-04-08 01:13:24'),
(26, 'smtp_notif_host', 'mail.vextra.cl', NULL, '2026-04-08 01:13:24'),
(27, 'smtp_notif_port', '465', NULL, '2026-04-08 01:13:24'),
(28, 'smtp_notif_usuario', 'noresponder@vextra.cl', NULL, '2026-04-08 01:13:24'),
(29, 'smtp_notif_encryption', 'ssl', NULL, '2026-04-08 01:13:24'),
(30, 'smtp_notif_remitente_correo', 'noresponder@vextra.cl', NULL, '2026-04-08 01:13:24'),
(31, 'smtp_notif_remitente_nombre', 'Vextra Notificaciones', NULL, '2026-04-08 01:13:24'),
(32, 'imap_notif_port', '993', NULL, '2026-04-08 01:13:24'),
(33, 'pop3_notif_port', '995', NULL, '2026-04-08 01:13:24'),
(34, 'smtp_notif_password', 'Tb*Kz{ny{[_E!%,Q', NULL, '2026-04-08 01:13:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuraciones_empresa`
--

CREATE TABLE `configuraciones_empresa` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `clave` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor` text COLLATE utf8mb4_unicode_ci,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion_pos`
--

CREATE TABLE `configuracion_pos` (
  `empresa_id` bigint UNSIGNED NOT NULL,
  `permitir_venta_sin_stock` tinyint(1) NOT NULL DEFAULT '0',
  `impuesto_por_defecto` decimal(8,2) NOT NULL DEFAULT '0.00',
  `usar_decimales` tinyint(1) NOT NULL DEFAULT '1',
  `cantidad_decimales` tinyint UNSIGNED NOT NULL DEFAULT '2',
  `moneda` enum('CLP','USD','EU') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CLP',
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracion_pos`
--

INSERT INTO `configuracion_pos` (`empresa_id`, `permitir_venta_sin_stock`, `impuesto_por_defecto`, `usar_decimales`, `cantidad_decimales`, `moneda`, `fecha_actualizacion`) VALUES
(69, 0, 19.00, 1, 2, 'CLP', '2026-04-08 15:53:41'),
(73, 0, 0.00, 1, 0, 'CLP', '2026-04-11 13:34:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contactos_cliente`
--

CREATE TABLE `contactos_cliente` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED DEFAULT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cargo` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `celular` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `es_principal` tinyint(1) NOT NULL DEFAULT '0',
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contactos_cliente`
--

INSERT INTO `contactos_cliente` (`id`, `empresa_id`, `cliente_id`, `nombre`, `cargo`, `correo`, `telefono`, `celular`, `es_principal`, `observaciones`, `fecha_creacion`) VALUES
(1, 69, 6, 'Gonzalo Freire', 'Jefe de Compras', 'ventas@repuestosmaule.cl', '+56 9 4113 7890', '+56 9 4113 7890', 1, 'Contacto principal para la gestión de pedidos de repuestos y logística en la zona de Talca.', '2026-04-08 23:48:22'),
(2, 69, 5, 'Felipe Carcamo', 'Administrador General', 'administracion@agrosur.cl', '+56 9 5656 3213', '', 1, 'Contacto principal para la gestión de suministros tecnológicos y coordinación de despacho en la Región de Los Lagos.', '2026-04-08 23:51:31'),
(3, 69, 4, 'Marcela Pedreros', 'Gerente de Operaciones', 'contacto@logiscl.cl', '+56 9 2998 8776', '+56 9 2998 8776', 0, 'Contacto para la coordinación de servicios de transporte y logística. Prefiere contacto vía correo para temas administrativos.', '2026-04-08 23:53:38'),
(4, 69, 4, 'Beatriz Sánchez', 'Jefa de Finanzas y Tesorería', 'finanzas@logiscl.cl', '', '+56 9 6655 4433', 1, 'Contacto exclusivo para el envío de facturas, estados de cuenta y confirmación de pagos por transferencia.', '2026-04-08 23:54:32'),
(5, 69, 3, 'Ricardo Lagos', 'Jefe de Adquisiciones', 'compras@mineraatacama.cl', '', '+56 9 6662 3344', 0, 'Contacto para la gestión de suministros técnicos y repuestos en la planta de Antofagasta.', '2026-04-09 00:02:05'),
(6, 69, 3, 'Gabriel Zapata', 'Analista de Cuentas por Pagar', 'finanzas@mineraatacama.cl', '', '+56 9 4455 6677', 1, 'Contacto principal para la gestión de suministros técnicos y repuestos en la planta de Antofagasta.', '2026-04-09 00:03:22'),
(7, 73, 8, 'María', 'jefe de compras', 'clientepruebados@correo.cl', '+56 9 5678 9012', '+56 9 5678 9012', 1, NULL, '2026-04-11 11:03:30'),
(8, 73, 9, 'contacto prueba cuatro', 'administrador', 'soledadmellazuniga@gmail.com', '+56 9 5678 9012', '12224541', 0, '', '2026-04-11 12:36:00'),
(9, 73, 10, 'Nombre contacto prueba cinco', 'encargado de compras', 'soledadmellazuniga@gmail.com', '+56 9 5678 9012', '95121410', 0, '', '2026-04-11 13:16:50'),
(10, 73, 10, 'contacto prueba  seis', 'jefe de compras', 'soledadmellazuniga@gmail.com', '', '', 0, '', '2026-04-11 13:46:08'),
(12, 69, 15, 'Pablo Rivas D.', 'Jefe de Adquisiciones', 'adquisiciones@utfsur.cl', '+56 9 7766 4231', '', 0, 'Contacto para el envío de facturas electrónicas y confirmación de transferencias bancarias.', '2026-04-12 22:17:16'),
(13, 69, 15, 'Francisco Diaz', 'Jefe de Operaciones', 'pagos@utfsur.cl', '+56 9 7890 4300', '', 1, 'Contacto principal para licitaciones y compras directas de equipamiento tecnológico.', '2026-04-12 22:18:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizaciones`
--

CREATE TABLE `cotizaciones` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `numero` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `consecutivo` int NOT NULL,
  `estado` enum('borrador','enviada','aprobada','rechazada','vencida','anulada') COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `descuento_tipo` enum('valor','porcentaje') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'valor',
  `descuento_valor` decimal(12,2) NOT NULL DEFAULT '0.00',
  `descuento` decimal(12,2) NOT NULL DEFAULT '0.00',
  `impuesto` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `terminos_condiciones` text COLLATE utf8mb4_unicode_ci,
  `lista_precio_id` bigint UNSIGNED DEFAULT NULL,
  `orden_compra_origen_id` bigint UNSIGNED DEFAULT NULL,
  `token_publico` char(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firma_cliente` mediumtext COLLATE utf8mb4_unicode_ci,
  `nombre_firmante_cliente` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_aprobacion_cliente` datetime DEFAULT NULL,
  `fecha_emision` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cotizaciones`
--

INSERT INTO `cotizaciones` (`id`, `empresa_id`, `cliente_id`, `usuario_id`, `numero`, `consecutivo`, `estado`, `subtotal`, `descuento_tipo`, `descuento_valor`, `descuento`, `impuesto`, `total`, `observaciones`, `terminos_condiciones`, `lista_precio_id`, `orden_compra_origen_id`, `token_publico`, `firma_cliente`, `nombre_firmante_cliente`, `fecha_aprobacion_cliente`, `fecha_emision`, `fecha_vencimiento`, `fecha_creacion`, `fecha_actualizacion`, `fecha_eliminacion`) VALUES
(1, 69, 3, 70, 'COT-069-000001', 1, 'aprobada', 3180000.00, 'valor', 0.00, 0.00, 604200.00, 3784200.00, 'Cumplir con la aprobación/desaprobación dentro de la fecha para ejecutarla al día hábil siguiente en caso de ser aceptada', '', NULL, NULL, '9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d', 'data:image/png;base64,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', 'Marcela Contreras', '2026-04-10 00:48:57', '2026-04-01', '2026-04-23', '2026-04-09 01:09:50', '2026-04-10 01:48:57', NULL),
(2, 69, 6, 70, 'COT-069-000002', 2, 'rechazada', 475000.00, 'porcentaje', 15.00, 84787.50, 90250.00, 480462.50, '', '', NULL, NULL, '5b4207e52fcdabce2a52fcc06b44c52afab32429b1862884b01c97d518e06ff6', NULL, NULL, NULL, '2026-04-01', '2026-04-08', '2026-04-09 01:20:12', NULL, NULL),
(3, 69, 5, 70, 'COT-069-000003', 3, 'aprobada', 1005000.00, 'valor', 0.00, 0.00, 190950.00, 1195950.00, 'Nos pondremos en contacto de dentro de las proximas 24 horas despues de la aprobación', '', NULL, NULL, '3288679eb7a36e7cf1970b4b6a9aca60e99be0cd9f463572a843a90a5759d853', NULL, NULL, NULL, '2026-04-01', '2026-04-09', '2026-04-09 01:22:21', '2026-04-10 00:17:47', NULL),
(4, 69, 6, 70, 'COT-069-000004', 4, 'enviada', 4100000.00, 'valor', 0.00, 0.00, 779000.00, 4879000.00, '', '', NULL, NULL, '10845f751d4caa58f79924a009600e3a4a4b9ad41f7d3812c1fa42b77aa983f5', NULL, NULL, NULL, '2026-04-09', '2026-04-11', '2026-04-09 01:28:45', '2026-04-10 01:34:59', NULL),
(5, 69, 4, 70, 'COT-069-000005', 5, 'vencida', 980000.00, 'valor', 0.00, 0.00, 186200.00, 1166200.00, '', '', NULL, NULL, '7e071072070e704e43038660cd2afd7815ab2b03f9d3603c3a5da0857002f233', NULL, NULL, NULL, '2026-04-01', '2026-04-08', '2026-04-09 01:30:24', '2026-04-09 01:32:03', NULL),
(6, 73, 8, 74, 'COT-073-000001', 1, 'aprobada', 107500.00, 'valor', 0.00, 0.00, 20425.00, 127925.00, '', '', NULL, NULL, '8f20cebb32a2139439c4d8e83b07db250cf13dcb181e496ecf5d5c3042deb0a5', NULL, NULL, NULL, '2026-04-11', '2026-04-26', '2026-04-11 12:06:25', '2026-04-11 12:14:11', NULL),
(7, 73, 8, 74, 'COT-073-000002', 2, 'aprobada', 162000.00, 'valor', 0.00, 0.00, 30780.00, 192780.00, '', '', 4, NULL, 'ee150769c99642bf880c5e0bc52aadcddd66eedeba0bb13ad61c1ef4889ee65f', 'data:image/png;base64,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', 'encargada de compras', '2026-04-11 11:22:14', '2026-04-11', '2026-04-26', '2026-04-11 12:19:49', '2026-04-11 12:22:14', NULL);
INSERT INTO `cotizaciones` (`id`, `empresa_id`, `cliente_id`, `usuario_id`, `numero`, `consecutivo`, `estado`, `subtotal`, `descuento_tipo`, `descuento_valor`, `descuento`, `impuesto`, `total`, `observaciones`, `terminos_condiciones`, `lista_precio_id`, `orden_compra_origen_id`, `token_publico`, `firma_cliente`, `nombre_firmante_cliente`, `fecha_aprobacion_cliente`, `fecha_emision`, `fecha_vencimiento`, `fecha_creacion`, `fecha_actualizacion`, `fecha_eliminacion`) VALUES
(8, 73, 9, 74, 'COT-073-000003', 3, 'aprobada', 36000.00, 'valor', 0.00, 0.00, 6840.00, 42840.00, '', '', NULL, NULL, '807530a17b97bc5658f50f0a5b57b198fac0802bcd089fca81ea1a64aa6de7f3', 'data:image/png;base64,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', 'encarga de compras', '2026-04-11 12:39:49', '2026-04-11', '2026-04-26', '2026-04-11 13:37:46', '2026-04-11 13:39:49', NULL),
(9, 73, 9, 74, 'COT-073-000004', 4, 'rechazada', 64000.00, 'valor', 0.00, 0.00, 12160.00, 76160.00, '', '', NULL, NULL, 'c095525847379fe79af9f55ffb523aa1aba91ad80c3f93d66fa780fa6bd8f2e4', NULL, NULL, NULL, '2026-04-11', '2026-04-26', '2026-04-11 13:41:20', '2026-04-11 13:43:47', NULL),
(10, 73, 10, 74, 'COT-073-000005', 5, 'aprobada', 131400.00, 'valor', 0.00, 0.00, 24966.00, 156366.00, '', '', NULL, NULL, '3b279446b8deb3f5bcdec97c6d1d2aa527e8f761ad8b6e6643f18aadb9203d4c', 'data:image/png;base64,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', 'encargada de compras', '2026-04-11 13:35:45', '2026-04-11', '2026-04-26', '2026-04-11 14:34:52', '2026-04-11 14:35:45', NULL),
(11, 73, 10, 74, 'COT-073-000006', 6, 'rechazada', 113400.00, 'valor', 0.00, 0.00, 21546.00, 134946.00, '', '', NULL, NULL, '690ce7f200db3cf3864006599c4ef8d4d7cc1c3fd9706c2c75d74f92c66aec38', NULL, NULL, NULL, '2026-04-11', '2026-04-26', '2026-04-11 14:53:52', '2026-04-11 14:54:41', NULL);
INSERT INTO `cotizaciones` (`id`, `empresa_id`, `cliente_id`, `usuario_id`, `numero`, `consecutivo`, `estado`, `subtotal`, `descuento_tipo`, `descuento_valor`, `descuento`, `impuesto`, `total`, `observaciones`, `terminos_condiciones`, `lista_precio_id`, `orden_compra_origen_id`, `token_publico`, `firma_cliente`, `nombre_firmante_cliente`, `fecha_aprobacion_cliente`, `fecha_emision`, `fecha_vencimiento`, `fecha_creacion`, `fecha_actualizacion`, `fecha_eliminacion`) VALUES
(15, 69, 15, 70, 'COT-069-000006', 6, 'aprobada', 8708250.00, 'valor', 0.00, 0.00, 1654567.50, 10362817.50, '', '', 2, NULL, '619ca47311e13911eb364626bd8a1bb969f3802d4bde28fa0657aa9496eb52b0', 'data:image/png;base64,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', 'Pablo Rivas', '2026-04-12 22:22:49', '2026-04-11', '2026-04-13', '2026-04-12 23:20:53', '2026-04-12 23:22:49', NULL),
(16, 69, 15, 70, 'COT-069-000007', 7, 'enviada', 4932500.00, 'valor', 0.00, 0.00, 937175.00, 5869675.00, '', '', 11, NULL, '8465b50cbc77f1c09583a136f3bf47d288706ba71cddb2b43133ed59e2dfb883', NULL, NULL, NULL, '2026-04-13', '2026-04-28', '2026-04-13 01:08:27', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos_plantillas`
--

CREATE TABLE `documentos_plantillas` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_documento` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cotizacion',
  `terminos_defecto` text COLLATE utf8mb4_unicode_ci,
  `observaciones_defecto` text COLLATE utf8mb4_unicode_ci,
  `firma` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pie_documento` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('activo','inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id` bigint UNSIGNED NOT NULL,
  `razon_social` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_comercial` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identificador_fiscal` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ciudad` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pais` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `etiqueta_rubro` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `etiqueta_frases` text COLLATE utf8mb4_unicode_ci,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slider_imagen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slider_imagen_secundaria` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slider_titulo` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slider_bajada` varchar(220) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slider_boton_texto` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slider_boton_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_topbar_texto` varchar(220) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_nosotros_titulo` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_nosotros_descripcion` text COLLATE utf8mb4_unicode_ci,
  `catalogo_nosotros_imagen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_nosotros_banner_imagen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_nosotros_bloque_titulo` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_nosotros_bloque_texto` text COLLATE utf8mb4_unicode_ci,
  `catalogo_contacto_titulo` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_contacto_descripcion` text COLLATE utf8mb4_unicode_ci,
  `catalogo_contacto_horario` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_contacto_whatsapp` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_contacto_form_titulo` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_contacto_form_subtitulo` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_contacto_form_bajada` text COLLATE utf8mb4_unicode_ci,
  `catalogo_contacto_form_correo_destino` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_contacto_form_campos` text COLLATE utf8mb4_unicode_ci,
  `catalogo_contacto_form_texto_boton` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_contacto_mapa_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_contacto_mapa_activo` tinyint(1) NOT NULL DEFAULT '1',
  `catalogo_social_facebook` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_social_instagram` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_social_tiktok` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_social_linkedin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_social_youtube` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_color_primario` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_color_acento` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catalogo_columnas_productos` tinyint UNSIGNED NOT NULL DEFAULT '3',
  `imap_host` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imap_port` smallint UNSIGNED DEFAULT NULL,
  `imap_encryption` enum('ssl','tls','none') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imap_usuario` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imap_password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imap_remitente_correo` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imap_remitente_nombre` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('activa','suspendida','vencida','cancelada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activa',
  `fecha_activacion` date DEFAULT NULL,
  `plan_id` bigint UNSIGNED DEFAULT NULL,
  `flow_customer_id` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flow_medio_pago_registrado` tinyint(1) NOT NULL DEFAULT '0',
  `flow_estado_registro` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flow_ultima_sincronizacion` datetime DEFAULT NULL,
  `observaciones_internas` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id`, `razon_social`, `nombre_comercial`, `identificador_fiscal`, `correo`, `telefono`, `direccion`, `ciudad`, `pais`, `descripcion`, `etiqueta_rubro`, `etiqueta_frases`, `logo`, `slider_imagen`, `slider_imagen_secundaria`, `slider_titulo`, `slider_bajada`, `slider_boton_texto`, `slider_boton_url`, `catalogo_topbar_texto`, `catalogo_nosotros_titulo`, `catalogo_nosotros_descripcion`, `catalogo_nosotros_imagen`, `catalogo_nosotros_banner_imagen`, `catalogo_nosotros_bloque_titulo`, `catalogo_nosotros_bloque_texto`, `catalogo_contacto_titulo`, `catalogo_contacto_descripcion`, `catalogo_contacto_horario`, `catalogo_contacto_whatsapp`, `catalogo_contacto_form_titulo`, `catalogo_contacto_form_subtitulo`, `catalogo_contacto_form_bajada`, `catalogo_contacto_form_correo_destino`, `catalogo_contacto_form_campos`, `catalogo_contacto_form_texto_boton`, `catalogo_contacto_mapa_url`, `catalogo_contacto_mapa_activo`, `catalogo_social_facebook`, `catalogo_social_instagram`, `catalogo_social_tiktok`, `catalogo_social_linkedin`, `catalogo_social_youtube`, `catalogo_color_primario`, `catalogo_color_acento`, `catalogo_columnas_productos`, `imap_host`, `imap_port`, `imap_encryption`, `imap_usuario`, `imap_password`, `imap_remitente_correo`, `imap_remitente_nombre`, `estado`, `fecha_activacion`, `plan_id`, `flow_customer_id`, `flow_medio_pago_registrado`, `flow_estado_registro`, `flow_ultima_sincronizacion`, `observaciones_internas`, `fecha_creacion`, `fecha_actualizacion`, `fecha_eliminacion`) VALUES
(1, 'CotizaPro SAS', 'CotizaPro Plataforma', '900111222', 'admin@cotizapro.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'activa', '2026-04-07', 3, NULL, 0, NULL, NULL, NULL, '2026-04-07 01:23:58', NULL, NULL),
(58, '17258916-2', 'sole', '17258916-2', 'soledadmellazuniga@gmail.com', '+56965827533', 'Parma 1310', 'Los Angeles', 'Chile', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'cancelada', '2026-04-08', 1, NULL, 0, NULL, NULL, NULL, '2026-04-08 02:12:06', '2026-04-08 02:14:04', '2026-04-08 02:14:04'),
(65, '17258916-2', 'sole', '17258916-2', 'soledadmellazuniga@gmail.com', '+56965827533', 'Parma 1310', 'Los Angeles', 'Chile', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'cancelada', '2026-04-08', 1, NULL, 0, NULL, NULL, NULL, '2026-04-08 02:28:19', '2026-04-08 02:32:34', '2026-04-08 02:32:34'),
(66, '17258916-2', 'sole', '17258916-2', 'soledadmellazuniga@gmail.com', '+56965827533', 'Parma 1310', 'Los Angeles', 'Chile', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'cancelada', '2026-04-08', 1, NULL, 0, NULL, NULL, NULL, '2026-04-08 02:37:07', '2026-04-08 03:38:20', '2026-04-08 03:38:20'),
(67, '156267732', 'sole', '156267732', 'pablitoislamella@gmail.com', '+56965827533', 'Parma 1310', 'Los Angeles', 'Chile', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'cancelada', '2026-04-08', 1, NULL, 0, NULL, NULL, NULL, '2026-04-08 02:40:33', '2026-04-08 03:38:15', '2026-04-08 03:38:15'),
(68, 'Acquaperla SpA', 'Go Creative', '156267732', 'erwin.2785@gmail.com', '+56944627287', 'Parma', 'Santiago de Chile (Santiago, Chile)', 'Colombia', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'cancelada', '2026-04-08', 1, NULL, 0, NULL, NULL, NULL, '2026-04-08 03:38:50', '2026-04-12 00:32:36', '2026-04-12 00:32:36'),
(69, 'Empresa estudio', 'Empresa estudio SPA', '77222333-3', 'vextracl@gmail.com', '9 4567 6767', 'Av. Vicuña Mackenna 345', 'Concepción', 'Chile', NULL, NULL, NULL, '/uploads/logos/logo_empresa_69_20260412222730.png', '/uploads/catalogo_slider/69/slider_catalogo_principal_69_20260414202809.png', '/uploads/catalogo_slider/69/slider_catalogo_secundaria_69_20260414202809.png', 'Innovación y Rendimiento en un solo lugar', 'Descubre nuestra nueva línea de procesadores Core-X y almacenamiento SSD de alta velocidad. Equipamiento profesional para mentes creativas.', 'Ver Catálogo', '', '💻 Soluciones Tecnológicas de Alto Rendimiento • Envíos a todo Chile • Garantía Pro', 'Innovación y Rendimiento en un solo lugar: Empresa Studio', 'En Empresa Studio, nos especializamos en potenciar la infraestructura digital de negocios que no se detienen. Con años de experiencia en el sector tecnológico, nuestra propuesta de valor se centra en entregar hardware y soluciones de alto rendimiento que garantizan estabilidad, velocidad y escalabilidad. No solo vendemos equipos; diseñamos el ecosistema tecnológico que tu empresa necesita para liderar su industria.', '/uploads/catalogo_slider/69/slider_catalogo_de nosotros_69_20260415155958.png', '/uploads/catalogo_slider/69/slider_catalogo_banner nosotros_69_20260415155958.png', 'Compromiso con la Excelencia Tecnológica', 'Nuestra presencia en el mercado se define por la selección rigurosa de cada componente. Desde servidores y redes de alta gama hasta estaciones de trabajo avanzadas, acompañamos a nuestros clientes en cada paso de su transformación digital, asegurando que cada inversión se traduzca en una ventaja competitiva real.', 'Conectemos tu Próximo Proyecto', '¿Listo para elevar el estándar tecnológico de tu empresa? Nuestro equipo de expertos está disponible para asesorarte en la selección de hardware y soluciones de infraestructura que mejor se adapten a tus objetivos de rendimiento.', 'Lunes a Viernes de 08:00 a 18:00', '+56 9 7833 2399', 'Solicita una Asesoría Especializada', 'Dejanos tus datos para contactarte', 'Completa este formulario y un consultor técnico de Empresa Studio se pondrá en contacto contigo en menos de 24 horas hábiles para brindarte una solución a medida.', 'vextracl@gmail.com', '[\"nombre\",\"telefono\",\"email\",\"asunto\",\"mensaje\"]', 'Enviar Mensaje', '', 1, 'https://facebook.com/empresastudio', 'https://instagram.com/empresastudio', '', '', '', '#2D3134', '#BDB3A7', 3, '', 993, 'tls', 'superadmin@cotizapro.com', 'Demo1234*', '', '', 'activa', '2026-04-08', 2, NULL, 0, NULL, NULL, NULL, '2026-04-08 03:49:21', '2026-04-15 17:00:27', NULL),
(70, 'Cliente Prueba dos', 'Nombre Comercial Prueba dos', '172589162', 'soledadmellazuniga@gmail.com', '+56965827533', 'Parma 1310', 'Los Angeles', 'Chile', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'cancelada', '2026-04-10', 1, NULL, 0, NULL, NULL, NULL, '2026-04-10 02:06:27', '2026-04-12 00:32:26', '2026-04-12 00:32:26'),
(71, 'Acquaperla SpA', 'Go Creative', '666666-6', 'contacto@gocreative.cl', '+56944627287', 'Parma', 'Santiago de Chile (Santiago, Chile)', 'Chile', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'cancelada', '2026-04-11', 1, 'cus_e3155abb7c', 0, NULL, '2026-04-11 02:06:31', NULL, '2026-04-11 02:06:29', '2026-04-11 02:15:05', '2026-04-11 02:15:05'),
(72, 'Acquaperla SpA', 'Go Creative', '666666-6', 'eisla@fvolcan.cl', '+56944627287', 'Parma', 'Los angeles', 'Chile', NULL, NULL, NULL, '/uploads/logos/logo_empresa_72_20260411142145.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, '', 993, 'tls', 'superadmin@cotizapro.com', 'Demo1234*', '', '', 'cancelada', '2026-04-11', 1, NULL, 0, NULL, NULL, NULL, '2026-04-11 02:15:09', '2026-04-12 02:06:45', '2026-04-12 02:06:45'),
(73, 'Cliente Prueba dos', 'Nombre Comercial Prueba dos', '251321795', 'soledadmellazuniga@gmail.com', '+56965827533', 'Parma 1310', 'Los Angeles', 'Chile', NULL, NULL, NULL, '/uploads/logos/logo_empresa_73_20260411214749.png', '/uploads/catalogo_slider/73/slider_catalogo_73_20260414011849.jpeg', NULL, 'soy un titulo', 'soy una descripcion', 'soy un boton', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, '', 993, 'tls', 'superadmin@cotizapro.com', 'Demo1234*', '', '', 'activa', '2026-04-11', 1, NULL, 0, NULL, NULL, '', '2026-04-11 11:23:33', '2026-04-14 02:18:49', NULL),
(74, 'razon social prueba siete', 'Nombre comercial Prueba siete', '11.111.111-1', 'solcyta_240789@hotmail.com', '+56965827533', 'Parma 1310', 'Los Angeles', 'Chile', NULL, NULL, NULL, '/uploads/logos/logo_empresa_74_20260412023742.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, '', 993, 'tls', 'solcyta_240789@hotmail.com', 'Pablito1212', '', '', 'cancelada', '2026-04-11', 1, NULL, 0, NULL, NULL, NULL, '2026-04-11 18:32:29', '2026-04-12 03:49:16', '2026-04-12 03:49:16'),
(75, 'RAZON SOCIAL PRUEBA QUINCE', 'NOMBRE COMERCIAL PRUEBA QUINCE', '5555555-5', 'vicente.isla13@gmail.com', '+56965827533', 'Parma 1310', 'Los Angeles', 'Chile', NULL, NULL, NULL, '/uploads/logos/logo_empresa_75_20260411214648.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3, '', 993, 'tls', 'vicente.isla13@gmail.com', 'Pablito12121', '', '', 'cancelada', '2026-04-11', 2, NULL, 0, NULL, NULL, NULL, '2026-04-11 21:29:32', '2026-04-12 02:35:36', '2026-04-12 02:35:36'),
(77, 'Pv SportChile', 'Pv SportChile', '25132179-5', 'visla@pvsport.cl', '+56 9 6693 8730', 'Bio bio', 'Los Angeles', 'Chile', 'PV SPORT, equipamiento de tenis de mesa de calidad para todos los niveles. Compra fácil, rápido y al mejor precio.', 'tenis_mesa', '', '/uploads/logos/logo_empresa_77_20260414154337.png', '/uploads/catalogo_slider/77/slider_catalogo_principal_77_20260414181314.webp', '/uploads/catalogo_slider/77/slider_catalogo_secundaria_77_20260414182414.jpg', 'PV Sport  - Tenis de mesa', 'PV SPORT es tu tienda especializada en tenis de mesa, donde encontrarás todo el equipamiento que necesitas para jugar al máximo nivel. Ofrecemos paletas, pelotas, mesas, accesorios y repuestos de alta calidad.', 'Escribenos', 'https://www.google.com/search?q=fwf&oq=fwf&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORiABDIHCAEQLhiABDIHCAIQABiABDIHCAMQABiABDIHCAQQABiABDIJCAUQABgKGIAEMgcIBhAAGIAEMgcIBxAAGIAEMgcICBAAGIAEMgkICRAAGAoYgATSAQc4NDNqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8', 'Lo mejor en tenis de mesa - Envios a todo chile', 'Sobre PV SPORT', 'En PV SPORT nos especializamos en la venta de equipamiento para tenis de mesa, ofreciendo productos de calidad para jugadores de todos los niveles. Nuestro compromiso es acercar el mejor equipamiento deportivo a quienes buscan mejorar su rendimiento, entrenar con confianza y disfrutar cada partida.\r\n\r\nTrabajamos con una cuidada selección de paletas, pelotas, mesas y accesorios, priorizando calidad, durabilidad y rendimiento. Nos enfocamos en brindar una experiencia de compra simple, rápida y confiable, acompañando a cada cliente en su crecimiento dentro de este deporte.', '/uploads/catalogo_slider/77/slider_catalogo_de nosotros_77_20260415131526.jpg', '/uploads/catalogo_slider/77/slider_catalogo_banner nosotros_77_20260415131552.webp', 'Más sobre nosotros', 'Somos una empresa enfocada en el tenis de mesa, apasionados por el deporte y comprometidos con entregar soluciones reales a jugadores, clubes y entusiastas. En PV SPORT creemos que contar con el equipamiento adecuado marca la diferencia, por eso ofrecemos productos seleccionados que cumplen con altos estándares.\r\n\r\nNuestro objetivo es convertirnos en un referente en equipamiento de tenis de mesa, destacando por nuestra atención cercana, precios competitivos y constante actualización de productos.', '¿Necesitas asesoría en equipamiento de tenis de mesa?', 'En PV SPORT estamos para ayudarte. Si tienes dudas sobre nuestros productos, necesitas recomendaciones o quieres cotizar equipamiento, completa el formulario y te responderemos a la brevedad.\r\n\r\nTe brindamos atención personalizada para que encuentres exactamente lo que necesitas, ya seas principiante o jugador avanzado', '', '', '¿Necesitas asesoría en equipamiento de tenis de mesa?', 'Subtítulo formulario', 'En PV SPORT estamos para ayudarte. Si tienes dudas sobre nuestros productos, necesitas recomendaciones o quieres cotizar equipamiento, completa el formulario y te responderemos a la brevedad.\r\n\r\nTe brindamos atención personalizada para que encuentres exactamente lo que necesitas, ya seas principiante o jugador avanzado', 'erwin.2785@gmail.com', '[\"nombre\",\"telefono\",\"email\",\"asunto\",\"mensaje\",\"empresa\",\"direccion\"]', '', '', 1, '', '', '', '', '', '#3B0368', '#3B0368', 4, '', 993, 'tls', 'superadmin@cotizapro.com', 'Demo1234*', '', '', 'activa', '2026-04-14', 2, NULL, 0, NULL, NULL, NULL, '2026-04-14 15:20:28', '2026-04-17 18:59:59', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `flow_clientes`
--

CREATE TABLE `flow_clientes` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `flow_customer_id` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado_local` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `estado_flow` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token_registro` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_registro` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medio_pago_registrado` tinyint(1) NOT NULL DEFAULT '0',
  `payload_request` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `payload_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `flow_clientes`
--

INSERT INTO `flow_clientes` (`id`, `empresa_id`, `flow_customer_id`, `correo`, `nombre`, `estado_local`, `estado_flow`, `token_registro`, `url_registro`, `medio_pago_registrado`, `payload_request`, `payload_response`, `fecha_creacion`, `fecha_actualizacion`, `fecha_eliminacion`) VALUES
(1, 9, 'cus_rc10f8d5b1', 'javigonzalez2024@udec.cl', 'vichito isla', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"vichito isla\",\"email\":\"javigonzalez2024@udec.cl\",\"externalId\":\"9\"}', '{\"customerId\":\"cus_rc10f8d5b1\",\"created\":\"2026-04-07 17:42:23\",\"email\":\"javigonzalez2024@udec.cl\",\"name\":\"vichito isla\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"9\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 17:42:23', NULL, '2026-04-07 19:39:35'),
(2, 10, 'cus_e86c49dc4c', 'soledadmellazuniga@gmail.com', 'Sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"Sole\",\"email\":\"soledadmellazuniga@gmail.com\",\"externalId\":\"10\"}', '{\"customerId\":\"cus_e86c49dc4c\",\"created\":\"2026-04-07 17:52:50\",\"email\":\"soledadmellazuniga@gmail.com\",\"name\":\"Sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"10\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 17:52:50', NULL, '2026-04-07 19:39:29'),
(3, 16, 'cus_e2fb73e05d', 'eisla@gocreative.cl', 'Go Creative', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"Go Creative\",\"email\":\"eisla@gocreative.cl\",\"externalId\":\"16\"}', '{\"customerId\":\"cus_e2fb73e05d\",\"created\":\"2026-04-07 19:41:05\",\"email\":\"eisla@gocreative.cl\",\"name\":\"Go Creative\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"16\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 19:41:05', NULL, '2026-04-07 19:41:49'),
(4, 18, 'cus_lddab5895a', 'contacto@gocreative.cl', 'Go Creative', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"Go Creative\",\"email\":\"contacto@gocreative.cl\",\"externalId\":\"18\"}', '{\"customerId\":\"cus_lddab5895a\",\"created\":\"2026-04-07 19:42:40\",\"email\":\"contacto@gocreative.cl\",\"name\":\"Go Creative\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"18\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 19:42:40', NULL, '2026-04-07 20:04:31'),
(5, 19, 'cus_nb6db01a36', 'rrss@gocreative.cl', 'Go Creative22', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"Go Creative22\",\"email\":\"rrss@gocreative.cl\",\"externalId\":\"19\"}', '{\"customerId\":\"cus_nb6db01a36\",\"created\":\"2026-04-07 19:51:22\",\"email\":\"rrss@gocreative.cl\",\"name\":\"Go Creative22\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"19\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 19:51:22', NULL, '2026-04-07 20:04:18'),
(6, 20, 'cus_fa536595cf', 'cobranza@gocreative.cl', 'Go Creative22', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"Go Creative22\",\"email\":\"cobranza@gocreative.cl\",\"externalId\":\"20\"}', '{\"customerId\":\"cus_fa536595cf\",\"created\":\"2026-04-07 20:04:52\",\"email\":\"cobranza@gocreative.cl\",\"name\":\"Go Creative22\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"20\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 20:04:52', NULL, '2026-04-07 20:27:47'),
(7, 22, 'cus_me18fcb262', 'info@gocreative.cl', 'Go Creative', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"Go Creative\",\"email\":\"info@gocreative.cl\",\"externalId\":\"22\"}', '{\"customerId\":\"cus_me18fcb262\",\"created\":\"2026-04-07 20:30:48\",\"email\":\"info@gocreative.cl\",\"name\":\"Go Creative\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"22\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 20:30:48', NULL, '2026-04-07 22:40:34'),
(8, 24, 'cus_k0b4e2ac08', 'soledadmellazuniga@gmail.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"soledadmellazuniga@gmail.com\",\"externalId\":\"24\"}', '{\"customerId\":\"cus_k0b4e2ac08\",\"created\":\"2026-04-07 22:16:24\",\"email\":\"soledadmellazuniga@gmail.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"24\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 22:16:24', NULL, '2026-04-07 22:16:39'),
(9, 26, 'cus_g99162cb53', 'solemella@gmail.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"solemella@gmail.com\",\"externalId\":\"26\"}', '{\"customerId\":\"cus_g99162cb53\",\"created\":\"2026-04-07 22:19:50\",\"email\":\"solemella@gmail.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"26\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 22:19:50', NULL, '2026-04-07 22:31:11'),
(10, 28, 'cus_x4560ab431', 'pablitoislamella@gmail.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"pablitoislamella@gmail.com\",\"externalId\":\"28\"}', '{\"customerId\":\"cus_x4560ab431\",\"created\":\"2026-04-07 22:34:41\",\"email\":\"pablitoislamella@gmail.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"28\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 22:34:41', NULL, '2026-04-07 22:40:26'),
(11, 30, 'cus_zebe00587d', 'vicente.isla13@gmail.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"vicente.isla13@gmail.com\",\"externalId\":\"30\"}', '{\"customerId\":\"cus_zebe00587d\",\"created\":\"2026-04-07 23:06:14\",\"email\":\"vicente.isla13@gmail.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"30\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 23:06:14', NULL, '2026-04-07 23:17:52'),
(12, 31, 'cus_lb7b88ad77', 'ldpnfguksiwnizxxoq@nespf.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"ldpnfguksiwnizxxoq@nespf.com\",\"externalId\":\"31\"}', '{\"customerId\":\"cus_lb7b88ad77\",\"created\":\"2026-04-07 23:17:56\",\"email\":\"ldpnfguksiwnizxxoq@nespf.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"31\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 23:17:57', NULL, '2026-04-07 23:24:13'),
(13, 32, 'cus_s5d549183b', 'khmzckhoazvukjpvvw@xfavaj.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"khmzckhoazvukjpvvw@xfavaj.com\",\"externalId\":\"32\"}', '{\"customerId\":\"cus_s5d549183b\",\"created\":\"2026-04-07 23:26:43\",\"email\":\"khmzckhoazvukjpvvw@xfavaj.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"32\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 23:26:43', NULL, '2026-04-07 23:31:42'),
(14, 33, 'cus_f8fd7b594a', 'flxctebxpqttxhwmsu@nesopf.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"flxctebxpqttxhwmsu@nesopf.com\",\"externalId\":\"33\"}', '{\"customerId\":\"cus_f8fd7b594a\",\"created\":\"2026-04-07 23:39:08\",\"email\":\"flxctebxpqttxhwmsu@nesopf.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"33\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 23:39:08', NULL, '2026-04-07 23:49:25'),
(15, 34, 'cus_v6118d3a3b', 'qthkxihsqqjlyrevjc@enotj.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"qthkxihsqqjlyrevjc@enotj.com\",\"externalId\":\"34\"}', '{\"customerId\":\"cus_v6118d3a3b\",\"created\":\"2026-04-07 23:49:28\",\"email\":\"qthkxihsqqjlyrevjc@enotj.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"34\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 23:49:28', NULL, '2026-04-07 23:50:27'),
(16, 35, 'cus_ae7bdab0a2', 'ylppakhgfuxlsxlovo@nespf.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"ylppakhgfuxlsxlovo@nespf.com\",\"externalId\":\"35\"}', '{\"customerId\":\"cus_ae7bdab0a2\",\"created\":\"2026-04-07 23:54:42\",\"email\":\"ylppakhgfuxlsxlovo@nespf.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"35\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-07 23:54:42', NULL, '2026-04-08 00:02:12'),
(17, 36, 'cus_i166f645a3', 'ctneuxkhbscegzgmyh@fxavaj.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"ctneuxkhbscegzgmyh@fxavaj.com\",\"externalId\":\"36\"}', '{\"customerId\":\"cus_i166f645a3\",\"created\":\"2026-04-08 00:02:14\",\"email\":\"ctneuxkhbscegzgmyh@fxavaj.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"36\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-08 00:02:14', NULL, '2026-04-08 00:05:32'),
(18, 38, 'cus_o6d3979756', 'eojpcptmupsuyzglgo@fxavaj.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"eojpcptmupsuyzglgo@fxavaj.com\",\"externalId\":\"38\"}', '{\"customerId\":\"cus_o6d3979756\",\"created\":\"2026-04-08 00:08:56\",\"email\":\"eojpcptmupsuyzglgo@fxavaj.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"38\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-08 00:08:56', NULL, '2026-04-08 00:15:54'),
(19, 39, 'cus_ucb9030584', 'uafzebuyukgyskhclg@enotj.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"uafzebuyukgyskhclg@enotj.com\",\"externalId\":\"39\"}', '{\"customerId\":\"cus_ucb9030584\",\"created\":\"2026-04-08 00:26:38\",\"email\":\"uafzebuyukgyskhclg@enotj.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"39\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-08 00:26:38', NULL, '2026-04-08 00:38:34'),
(20, 40, 'cus_v2f4ed71f8', 'kulriwtwulngtpqwwo@enotj.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"kulriwtwulngtpqwwo@enotj.com\",\"externalId\":\"40\"}', '{\"customerId\":\"cus_v2f4ed71f8\",\"created\":\"2026-04-08 00:39:54\",\"email\":\"kulriwtwulngtpqwwo@enotj.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"40\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-08 00:39:54', NULL, '2026-04-08 00:44:27'),
(21, 43, 'cus_we9c387b68', 'cvoliqpjqzkllgzaid@nesopf.com', 'sole', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"sole\",\"email\":\"cvoliqpjqzkllgzaid@nesopf.com\",\"externalId\":\"43\"}', '{\"customerId\":\"cus_we9c387b68\",\"created\":\"2026-04-08 00:46:07\",\"email\":\"cvoliqpjqzkllgzaid@nesopf.com\",\"name\":\"sole\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"43\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-08 00:46:07', NULL, '2026-04-08 00:55:46'),
(22, 71, 'cus_e3155abb7c', 'contacto@gocreative.cl', 'Go Creative', 'activo', 'creado', NULL, NULL, 0, '{\"name\":\"Go Creative\",\"email\":\"contacto@gocreative.cl\",\"externalId\":\"71\"}', '{\"customerId\":\"cus_e3155abb7c\",\"created\":\"2026-04-11 02:06:31\",\"email\":\"contacto@gocreative.cl\",\"name\":\"Go Creative\",\"pay_mode\":\"manual\",\"creditCardType\":null,\"last4CardDigits\":null,\"externalId\":\"71\",\"status\":1,\"registerDate\":null,\"tbkUser\":null}', '2026-04-11 02:06:31', NULL, '2026-04-11 02:15:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `flow_configuracion`
--

CREATE TABLE `flow_configuracion` (
  `id` bigint UNSIGNED NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '0',
  `entorno` enum('sandbox','produccion') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `api_key` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secret_key_enc` text COLLATE utf8mb4_unicode_ci,
  `base_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `habilitar_pagos_unicos` tinyint(1) NOT NULL DEFAULT '1',
  `habilitar_suscripciones` tinyint(1) NOT NULL DEFAULT '1',
  `url_confirmacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_retorno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_webhook_pago` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_webhook_suscripcion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url_retorno_registro` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `flow_configuracion`
--

INSERT INTO `flow_configuracion` (`id`, `activo`, `entorno`, `api_key`, `secret_key_enc`, `base_url`, `habilitar_pagos_unicos`, `habilitar_suscripciones`, `url_confirmacion`, `url_retorno`, `url_webhook_pago`, `url_webhook_suscripcion`, `url_retorno_registro`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 1, 'produccion', '484DFD4D-0A41-424D-A573-95BDAF374LD4', 'NDQ0YTdiZjdiM2JhNGMzYTg3MDhjZTlkN2JlMjQxMjIzNjA0ZWU5Ng==', 'https://sandbox.flow.cl/api', 1, 1, 'https://vextra.cl/flow/webhook/payment-confirmation', 'https://vextra.cl/iniciar-sesion', 'https://vextra.cl/flow/webhook/payment-confirmation', '', 'https://vextra.cl/flow/retorno/registro', '2026-04-07 15:44:57', '2026-04-07 23:17:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `flow_configuraciones_empresa`
--

CREATE TABLE `flow_configuraciones_empresa` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `api_key` varchar(180) COLLATE utf8mb3_unicode_ci NOT NULL,
  `secret_key_enc` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `entorno` enum('sandbox','produccion') COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'sandbox',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `base_url` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `flow_configuraciones_empresa`
--

INSERT INTO `flow_configuraciones_empresa` (`id`, `empresa_id`, `api_key`, `secret_key_enc`, `entorno`, `activo`, `base_url`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 73, '644821F3-A9E2-4284-AAAB-3DCLF0EF3BF9', 'NDdmZWUxOTc5NzU1MmEzOTM4YjBkOTZiMzQxMDVjYWFhOWIyOWE2Mg==', 'produccion', 1, NULL, '2026-04-14 01:00:28', '2026-04-14 01:00:28'),
(2, 77, '644821F3-A9E2-4284-AAAB-3DCLF0EF3BF9', 'NDdmZWUxOTc5NzU1MmEzOTM4YjBkOTZiMzQxMDVjYWFhOWIyOWE2Mg==', 'produccion', 1, NULL, '2026-04-15 12:40:27', '2026-04-15 12:43:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `flow_logs`
--

CREATE TABLE `flow_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED DEFAULT NULL,
  `admin_usuario_id` bigint UNSIGNED DEFAULT NULL,
  `tipo` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nivel` enum('info','warning','error') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'info',
  `mensaje` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `referencia` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Volcado de datos para la tabla `flow_logs`
--

INSERT INTO `flow_logs` (`id`, `empresa_id`, `admin_usuario_id`, `tipo`, `nivel`, `mensaje`, `referencia`, `payload`, `fecha_creacion`) VALUES
(2, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":0,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 17:42:25\",\"delete_userId\":323345}', '2026-04-07 17:42:25'),
(4, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":0,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"http:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 17:52:52\",\"delete_userId\":323345}', '2026-04-07 17:52:52'),
(5, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":0,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 19:24:26\",\"delete_userId\":323345}', '2026-04-07 19:24:26'),
(6, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_ANUAL', '{\"planId\":\"BASICO_ANUAL\",\"name\":\"Básico Anual\",\"currency\":\"CLP\",\"amount\":\"162000\",\"interval\":4,\"interval_count\":1,\"created\":\"2026-04-06 12:36:40\",\"periods_number\":0,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:36:40\",\"updated_at\":\"2026-04-07 19:24:31\",\"delete_userId\":323345}', '2026-04-07 19:24:32'),
(7, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":0,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 19:26:04\",\"delete_userId\":323345}', '2026-04-07 19:26:04'),
(8, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":0,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 19:26:04\",\"delete_userId\":323345}', '2026-04-07 19:26:22'),
(9, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":0,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 19:26:04\",\"delete_userId\":323345}', '2026-04-07 19:26:26'),
(10, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":0,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 19:26:04\",\"delete_userId\":323345}', '2026-04-07 19:26:44'),
(11, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'PROFESIONAL_MENSUAL', '{\"planId\":\"PROFESIONAL_MENSUAL\",\"name\":\"Profesional Emprende Mensual\",\"currency\":\"CLP\",\"amount\":\"26000\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:09:29\",\"periods_number\":0,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:09:29\",\"updated_at\":\"2026-04-07 19:27:23\",\"delete_userId\":323345}', '2026-04-07 19:27:23'),
(12, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'PROFESIONAL_ANUAL', '{\"planId\":\"PROFESIONAL_ANUAL\",\"name\":\"Profesional Emprende Anual\",\"currency\":\"CLP\",\"amount\":\"280800\",\"interval\":4,\"interval_count\":1,\"created\":\"2026-04-07 19:27:25\",\"periods_number\":0,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":1,\"public\":0,\"created_at\":\"2026-04-07 19:27:25\",\"updated_at\":\"2026-04-07 19:27:25\",\"delete_userId\":null}', '2026-04-07 19:27:25'),
(13, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'EMPRESA_MENSUAL', '{\"planId\":\"EMPRESA_MENSUAL\",\"name\":\"Empresa Mensual\",\"currency\":\"CLP\",\"amount\":\"55000\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-07 19:27:34\",\"periods_number\":0,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":1,\"public\":0,\"created_at\":\"2026-04-07 19:27:34\",\"updated_at\":\"2026-04-07 19:27:34\",\"delete_userId\":null}', '2026-04-07 19:27:34'),
(14, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'EMPRESA_ANUAL', '{\"planId\":\"EMPRESA_ANUAL\",\"name\":\"Empresa Anual\",\"currency\":\"CLP\",\"amount\":\"561000\",\"interval\":4,\"interval_count\":1,\"created\":\"2026-04-07 19:27:37\",\"periods_number\":0,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":1,\"public\":0,\"created_at\":\"2026-04-07 19:27:37\",\"updated_at\":\"2026-04-07 19:27:37\",\"delete_userId\":null}', '2026-04-07 19:27:37'),
(16, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'PROFESIONAL_MENSUAL', '{\"planId\":\"PROFESIONAL_MENSUAL\",\"name\":\"Profesional Emprende Mensual\",\"currency\":\"CLP\",\"amount\":\"26000\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:09:29\",\"periods_number\":0,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:09:29\",\"updated_at\":\"2026-04-07 19:27:23\",\"delete_userId\":323345}', '2026-04-07 19:41:07'),
(17, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'EMPRESA_MENSUAL', '{\"planId\":\"EMPRESA_MENSUAL\",\"name\":\"Empresa Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-07 19:27:34\",\"periods_number\":0,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":1,\"public\":0,\"created_at\":\"2026-04-07 19:27:34\",\"updated_at\":\"2026-04-07 19:42:06\",\"delete_userId\":null}', '2026-04-07 19:42:06'),
(18, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'PROFESIONAL_MENSUAL', '{\"planId\":\"PROFESIONAL_MENSUAL\",\"name\":\"Profesional Emprende Mensual\",\"currency\":\"CLP\",\"amount\":\"26000\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:09:29\",\"periods_number\":0,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:09:29\",\"updated_at\":\"2026-04-07 19:27:23\",\"delete_userId\":323345}', '2026-04-07 19:42:08'),
(19, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":0,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 19:26:04\",\"delete_userId\":323345}', '2026-04-07 19:42:10'),
(20, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'PROFESIONAL_MENSUAL', '{\"planId\":\"PROFESIONAL_MENSUAL\",\"name\":\"Profesional Emprende Mensual\",\"currency\":\"CLP\",\"amount\":\"26000\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:09:29\",\"periods_number\":0,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:09:29\",\"updated_at\":\"2026-04-07 19:27:23\",\"delete_userId\":323345}', '2026-04-07 19:42:15'),
(21, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'PROFESIONAL_ANUAL', '{\"planId\":\"PROFESIONAL_ANUAL\",\"name\":\"Profesional Emprende Anual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":4,\"interval_count\":1,\"created\":\"2026-04-07 19:27:25\",\"periods_number\":0,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":1,\"public\":0,\"created_at\":\"2026-04-07 19:27:25\",\"updated_at\":\"2026-04-07 19:42:18\",\"delete_userId\":null}', '2026-04-07 19:42:18'),
(23, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'PROFESIONAL_ANUAL', '{\"planId\":\"PROFESIONAL_ANUAL\",\"name\":\"Profesional Emprende Anual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":4,\"interval_count\":1,\"created\":\"2026-04-07 19:27:25\",\"periods_number\":0,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":1,\"public\":0,\"created_at\":\"2026-04-07 19:27:25\",\"updated_at\":\"2026-04-07 19:42:18\",\"delete_userId\":null}', '2026-04-07 19:42:42'),
(26, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', 'F38CAB817FC42EE777F8B902AFE5BA012EC7904I', '{\"token\":\"F38CAB817FC42EE777F8B902AFE5BA012EC7904I\"}', '2026-04-07 19:44:04'),
(28, NULL, NULL, 'plan', 'warning', 'Plan ya existía en Flow y se vinculó localmente', 'PROFESIONAL_ANUAL', '{\"status\":\"already_exists\",\"planId\":\"PROFESIONAL_ANUAL\",\"message\":\"El plan ya existía en Flow; no fue posible ejecutar update automático.\"}', '2026-04-07 19:51:24'),
(31, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', 'EFCF8F70CFFC8CE4AE5DBC0B535219058A51D05C', '{\"token\":\"EFCF8F70CFFC8CE4AE5DBC0B535219058A51D05C\"}', '2026-04-07 19:52:23'),
(33, NULL, NULL, 'plan', 'warning', 'Plan ya existía en Flow y se vinculó localmente', 'PROFESIONAL_ANUAL', '{\"status\":\"already_exists\",\"planId\":\"PROFESIONAL_ANUAL\",\"message\":\"El plan ya existía en Flow; no fue posible ejecutar update automático.\"}', '2026-04-07 20:04:54'),
(36, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '5071D5FDC1EFB0CB1EAAC99E6E879629FBAF7D4K', '{\"token\":\"5071D5FDC1EFB0CB1EAAC99E6E879629FBAF7D4K\"}', '2026-04-07 20:06:18'),
(37, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 20:27:51'),
(38, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 20:27:51'),
(39, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'EMPRESA_MENSUAL', '{\"planId\":\"EMPRESA_MENSUAL\",\"name\":\"Empresa Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-07 19:27:34\",\"periods_number\":1,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":1,\"public\":0,\"created_at\":\"2026-04-07 19:27:34\",\"updated_at\":\"2026-04-07 20:27:52\",\"delete_userId\":null}', '2026-04-07 20:27:52'),
(40, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 20:27:55'),
(41, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 20:27:56'),
(42, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'EMPRESA_ANUAL', '{\"planId\":\"EMPRESA_ANUAL\",\"name\":\"Empresa Anual\",\"currency\":\"CLP\",\"amount\":\"561000\",\"interval\":4,\"interval_count\":1,\"created\":\"2026-04-07 19:27:37\",\"periods_number\":1,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":1,\"public\":0,\"created_at\":\"2026-04-07 19:27:37\",\"updated_at\":\"2026-04-07 20:27:56\",\"delete_userId\":null}', '2026-04-07 20:27:56'),
(43, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 20:27:58'),
(44, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 20:27:59'),
(45, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/edit', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/edit\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This plan can not be modified because it has active subscribers\"}}', '2026-04-07 20:27:59'),
(46, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plan/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plan\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 20:28:00'),
(47, NULL, 1, 'plan', 'warning', 'Plan ya existía en Flow y se vinculó localmente', 'PROFESIONAL_ANUAL', '{\"status\":\"already_exists\",\"planId\":\"PROFESIONAL_ANUAL\",\"message\":\"El plan ya existía en Flow; no fue posible ejecutar update automático.\"}', '2026-04-07 20:28:00'),
(48, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 20:28:01'),
(49, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 20:28:02'),
(50, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'PROFESIONAL_MENSUAL', '{\"planId\":\"PROFESIONAL_MENSUAL\",\"name\":\"Profesional Emprende Mensual\",\"currency\":\"CLP\",\"amount\":\"26000\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:09:29\",\"periods_number\":1,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:09:29\",\"updated_at\":\"2026-04-07 20:28:03\",\"delete_userId\":323345}', '2026-04-07 20:28:03'),
(51, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 20:28:05'),
(52, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 20:28:06'),
(53, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_ANUAL', '{\"planId\":\"BASICO_ANUAL\",\"name\":\"Básico Pyme Anual\",\"currency\":\"CLP\",\"amount\":\"162000\",\"interval\":4,\"interval_count\":1,\"created\":\"2026-04-06 12:36:40\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:36:40\",\"updated_at\":\"2026-04-07 20:28:06\",\"delete_userId\":323345}', '2026-04-07 20:28:07'),
(54, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 20:28:09'),
(55, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 20:28:09'),
(56, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-07 20:28:10'),
(62, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 20:30:48'),
(63, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 20:30:49'),
(64, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/edit', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/edit\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This plan can not be modified because it has active subscribers\"}}', '2026-04-07 20:30:49'),
(65, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plan/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plan\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 20:30:50'),
(66, NULL, NULL, 'plan', 'warning', 'Plan ya existía en Flow y se vinculó localmente', 'PROFESIONAL_ANUAL', '{\"status\":\"already_exists\",\"planId\":\"PROFESIONAL_ANUAL\",\"message\":\"El plan ya existía en Flow; no fue posible ejecutar update automático.\"}', '2026-04-07 20:30:50'),
(67, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-07 20:30:51'),
(69, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 22:16:24'),
(70, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 22:16:25'),
(71, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/edit', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/edit\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This plan can not be modified because it has active subscribers\"}}', '2026-04-07 22:16:26'),
(72, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plan/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plan\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 22:16:26'),
(73, NULL, NULL, 'plan', 'warning', 'Plan ya existía en Flow y se vinculó localmente', 'PROFESIONAL_ANUAL', '{\"status\":\"already_exists\",\"planId\":\"PROFESIONAL_ANUAL\",\"message\":\"El plan ya existía en Flow; no fue posible ejecutar update automático.\"}', '2026-04-07 22:16:26'),
(74, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-07 22:16:27'),
(77, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 22:19:51'),
(78, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 22:19:51'),
(79, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/edit', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/edit\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This plan can not be modified because it has active subscribers\"}}', '2026-04-07 22:19:52'),
(80, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plan/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plan\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 22:19:53'),
(81, NULL, NULL, 'plan', 'warning', 'Plan ya existía en Flow y se vinculó localmente', 'PROFESIONAL_ANUAL', '{\"status\":\"already_exists\",\"planId\":\"PROFESIONAL_ANUAL\",\"message\":\"El plan ya existía en Flow; no fue posible ejecutar update automático.\"}', '2026-04-07 22:19:53'),
(82, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-07 22:19:53'),
(84, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', 'A847FF03239B6315A52B6DF16DCD085268F2240D', '{\"token\":\"A847FF03239B6315A52B6DF16DCD085268F2240D\"}', '2026-04-07 22:21:18'),
(90, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 22:34:42'),
(91, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 22:34:42'),
(92, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/edit', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/edit\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This plan can not be modified because it has active subscribers\"}}', '2026-04-07 22:34:43'),
(93, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plan/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plan\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 22:34:44'),
(94, NULL, NULL, 'plan', 'warning', 'Plan ya existía en Flow y se vinculó localmente', 'PROFESIONAL_ANUAL', '{\"status\":\"already_exists\",\"planId\":\"PROFESIONAL_ANUAL\",\"message\":\"El plan ya existía en Flow; no fue posible ejecutar update automático.\"}', '2026-04-07 22:34:44'),
(95, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-07 22:34:44'),
(97, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', 'A21FA7BC0F26027B8B6963FCD5C155373D8D5B5V', '{\"token\":\"A21FA7BC0F26027B8B6963FCD5C155373D8D5B5V\"}', '2026-04-07 22:36:05'),
(98, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-07 22:37:50'),
(100, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 23:06:15'),
(101, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 23:06:15'),
(102, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/edit', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/edit\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This plan can not be modified because it has active subscribers\"}}', '2026-04-07 23:06:16'),
(103, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plan/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plan\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 23:06:16'),
(104, NULL, NULL, 'plan', 'warning', 'Plan ya existía en Flow y se vinculó localmente', 'PROFESIONAL_ANUAL', '{\"status\":\"already_exists\",\"planId\":\"PROFESIONAL_ANUAL\",\"message\":\"El plan ya existía en Flow; no fue posible ejecutar update automático.\"}', '2026-04-07 23:06:16'),
(105, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-07 23:06:17'),
(107, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '3285B2477BE7D81FB30E8855B1C144C0073DA40O', '{\"token\":\"3285B2477BE7D81FB30E8855B1C144C0073DA40O\"}', '2026-04-07 23:07:28'),
(109, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 23:17:57'),
(110, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 23:17:58'),
(111, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/edit', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/edit\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This plan can not be modified because it has active subscribers\"}}', '2026-04-07 23:17:58'),
(112, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plan/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plan\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 23:17:59'),
(113, NULL, NULL, 'plan', 'warning', 'Plan ya existía en Flow y se vinculó localmente', 'PROFESIONAL_ANUAL', '{\"status\":\"already_exists\",\"planId\":\"PROFESIONAL_ANUAL\",\"message\":\"El plan ya existía en Flow; no fue posible ejecutar update automático.\"}', '2026-04-07 23:17:59'),
(114, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-07 23:18:00'),
(116, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '73BA8C7BDFCE6E8CC5BFFDFFFA58537A3966876T', '{\"token\":\"73BA8C7BDFCE6E8CC5BFFDFFFA58537A3966876T\"}', '2026-04-07 23:19:14'),
(118, NULL, 32, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 23:26:44'),
(119, NULL, 32, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 23:26:45'),
(120, NULL, 32, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-07 23:26:45'),
(121, NULL, 32, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-07 23:26:46'),
(123, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '8F0DB6369062C0476D9D36BBE33B88BA46C654FA', '{\"token\":\"8F0DB6369062C0476D9D36BBE33B88BA46C654FA\"}', '2026-04-07 23:28:02'),
(125, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 23:39:08'),
(126, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 23:39:09'),
(127, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-07 23:39:09'),
(128, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-07 23:39:10'),
(131, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 23:49:28'),
(132, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 23:49:29'),
(133, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-07 23:49:30'),
(134, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-07 23:49:30'),
(137, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-07 23:54:44'),
(138, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-07 23:54:45'),
(139, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-07 23:54:46'),
(140, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-07 23:54:46'),
(143, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 00:02:15'),
(144, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 00:02:15'),
(145, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 00:02:16'),
(146, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-08 00:02:16'),
(149, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 00:08:56'),
(150, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 00:08:57'),
(151, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 00:08:58'),
(152, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-08 00:08:58'),
(154, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '54CFE497E6F45F645F0CAD9928FCE34117795ABQ', '{\"token\":\"54CFE497E6F45F645F0CAD9928FCE34117795ABQ\"}', '2026-04-08 00:10:12'),
(156, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 00:26:39'),
(157, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 00:26:39'),
(158, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 00:26:40'),
(159, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-08 00:26:41'),
(161, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', 'A3A9C84C2805BC5E8FA14E62C8074CC5B4A7C2FQ', '{\"token\":\"A3A9C84C2805BC5E8FA14E62C8074CC5B4A7C2FQ\"}', '2026-04-08 00:27:59'),
(163, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 00:39:55'),
(164, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 00:39:55'),
(165, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 00:39:56'),
(166, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-08 00:39:57'),
(168, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', 'C9356948F49E06CCF3F9BE2E54F94E70F651A23R', '{\"token\":\"C9356948F49E06CCF3F9BE2E54F94E70F651A23R\"}', '2026-04-08 00:41:19'),
(170, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 00:46:07'),
(171, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 00:46:08'),
(172, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 00:46:08'),
(173, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-08 00:46:09'),
(175, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', 'C4783730C74DE548DF266F72AD53D471067C71EQ', '{\"token\":\"C4783730C74DE548DF266F72AD53D471067C71EQ\"}', '2026-04-08 00:47:25'),
(176, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 00:55:51'),
(177, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 00:55:51'),
(178, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 00:55:52'),
(180, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '59D5E2718378D569FBBDF7F72FA2F214C10941DT', '{\"token\":\"59D5E2718378D569FBBDF7F72FA2F214C10941DT\"}', '2026-04-08 00:57:16'),
(181, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 01:02:26'),
(182, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 01:02:27'),
(183, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 01:02:28'),
(185, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 01:06:56'),
(186, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 01:06:56'),
(187, NULL, 1, 'plan', 'info', 'Plan sincronizado con Flow', 'PROFESIONAL_MENSUAL', '{\"planId\":\"PROFESIONAL_MENSUAL\",\"name\":\"Profesional Emprende Mensual\",\"currency\":\"CLP\",\"amount\":\"26000\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:09:29\",\"periods_number\":1,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:09:29\",\"updated_at\":\"2026-04-07 20:28:03\",\"delete_userId\":323345}', '2026-04-08 01:06:57'),
(189, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 01:09:30');
INSERT INTO `flow_logs` (`id`, `empresa_id`, `admin_usuario_id`, `tipo`, `nivel`, `mensaje`, `referencia`, `payload`, `fecha_creacion`) VALUES
(190, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 01:09:30'),
(191, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plans/edit', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/edit\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This plan can not be modified because it has active subscribers\"}}', '2026-04-08 01:09:31'),
(192, NULL, 1, 'api', 'error', 'Flow POST con error HTTP', 'plan/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plan\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 01:09:32'),
(193, NULL, 1, 'plan', 'warning', 'Plan ya existía en Flow y se vinculó localmente', 'PROFESIONAL_ANUAL', '{\"status\":\"already_exists\",\"planId\":\"PROFESIONAL_ANUAL\",\"message\":\"El plan ya existía en Flow; no fue posible ejecutar update automático.\"}', '2026-04-08 01:09:32'),
(195, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '030BEA964AD80F38EDF2FCF153DF8B5A6A1CC72V', '{\"token\":\"030BEA964AD80F38EDF2FCF153DF8B5A6A1CC72V\"}', '2026-04-08 01:10:20'),
(196, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 01:16:15'),
(197, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 01:16:15'),
(198, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_ANUAL', '{\"planId\":\"BASICO_ANUAL\",\"name\":\"Básico Pyme Anual\",\"currency\":\"CLP\",\"amount\":\"162000\",\"interval\":4,\"interval_count\":1,\"created\":\"2026-04-06 12:36:40\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:36:40\",\"updated_at\":\"2026-04-07 20:28:06\",\"delete_userId\":323345}', '2026-04-08 01:16:16'),
(200, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 01:18:02'),
(201, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 01:18:03'),
(202, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 01:18:03'),
(204, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', 'DC500CF15928DF1FA87E6D944EFB7786DCA55FCO', '{\"token\":\"DC500CF15928DF1FA87E6D944EFB7786DCA55FCO\"}', '2026-04-08 01:19:13'),
(205, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 01:27:23'),
(206, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 01:27:24'),
(207, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 01:27:25'),
(210, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', '4B4F6AED73C0F76A17B419728D156F12A5EA267C', '{\"flowOrder\":165608267,\"commerceOrder\":\"EMP52-PLAN1-DDAEC80B\",\"requestDate\":\"2026-04-08 01:27:25\",\"status\":2,\"subject\":\"Cobro inicial plan por registro Básico Pyme (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"wbyqsvtsvsregqjndq@nespj.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-08 01:28:44\",\"media\":\"Webpay\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-09 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-08 01:28:46'),
(212, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 01:33:36'),
(213, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 01:33:36'),
(214, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 01:33:37'),
(217, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', 'EFFC9B48BA73EEE88E7016BFB632EE631281782B', '{\"flowOrder\":165608705,\"commerceOrder\":\"EMP53-PLAN1-EDF89B09\",\"requestDate\":\"2026-04-08 01:33:38\",\"status\":2,\"subject\":\"Cobro inicial plan por registro Básico Pyme (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"odujelwtlcuxkvxbob@nespj.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-08 01:35:45\",\"media\":\"Webpay\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-09 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-08 01:35:47'),
(219, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 01:45:07'),
(220, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 01:45:07'),
(221, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 01:45:08'),
(223, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 01:48:34'),
(224, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 01:48:35'),
(225, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 01:48:35'),
(228, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', '3D9B4ED607F9D10F31B7A476BAEEE87511A30E9O', '{\"flowOrder\":165609879,\"commerceOrder\":\"EMP55-PLAN1-C45BB519\",\"requestDate\":\"2026-04-08 01:48:36\",\"status\":3,\"subject\":\"Cobro inicial plan por registro Básico Pyme (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"mowbilpxbpcheadome@nesopf.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 01:51:40'),
(230, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 01:56:50'),
(231, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 01:56:50'),
(232, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 01:56:51'),
(236, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', 'FBF8960AD8D574906CC51F94B178EFC18838721U', '{\"flowOrder\":165610441,\"commerceOrder\":\"EMP56-PLAN1-0139D4CF\",\"requestDate\":\"2026-04-08 01:56:52\",\"status\":3,\"subject\":\"Cobro inicial plan por registro Básico Pyme (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"soledadmellazuniga@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 01:58:21'),
(237, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 02:00:57'),
(238, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 02:00:58'),
(239, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 02:00:59'),
(242, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', 'E53D9F1723D77A6E6DE9EDA0C51D6426C41B637E', '{\"flowOrder\":165610719,\"commerceOrder\":\"EMP57-PLAN1-7CB4F2A8\",\"requestDate\":\"2026-04-08 02:00:59\",\"status\":2,\"subject\":\"Cobro inicial plan por registro Básico Pyme (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"pablitoislamella@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-08 02:02:18\",\"media\":\"Webpay\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-09 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-08 02:02:19'),
(244, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 02:12:07'),
(245, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 02:12:07'),
(246, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 02:12:08'),
(251, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 02:28:20'),
(252, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 02:28:21'),
(253, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 02:28:22'),
(255, NULL, NULL, 'pago', 'info', 'Estado de pago sincronizado', '0A18D11396718AB35FA5F7C8AF6DD51190E3C58T', '{\"flowOrder\":165611687,\"commerceOrder\":\"EMP58-PLAN1-4D0FB79B\",\"requestDate\":\"2026-04-08 02:12:09\",\"status\":3,\"subject\":\"Cobro inicial plan por registro Básico Pyme (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"soledadmellazuniga@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 02:35:25'),
(256, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', '0A18D11396718AB35FA5F7C8AF6DD51190E3C58T', '{\"flowOrder\":165611687,\"commerceOrder\":\"EMP58-PLAN1-4D0FB79B\",\"requestDate\":\"2026-04-08 02:12:09\",\"status\":3,\"subject\":\"Cobro inicial plan por registro Básico Pyme (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"soledadmellazuniga@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 02:35:25'),
(257, NULL, NULL, 'pago', 'info', 'Estado de pago sincronizado', '0A18D11396718AB35FA5F7C8AF6DD51190E3C58T', '{\"flowOrder\":165611687,\"commerceOrder\":\"EMP58-PLAN1-4D0FB79B\",\"requestDate\":\"2026-04-08 02:12:09\",\"status\":3,\"subject\":\"Cobro inicial plan por registro Básico Pyme (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"soledadmellazuniga@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 02:35:25'),
(258, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 02:37:08'),
(259, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 02:37:08'),
(260, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 02:37:09'),
(271, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', 'E2B2124310115F3FDFDBA3D0E42D0AB63891D3AO', '{\"flowOrder\":165613217,\"commerceOrder\":\"EMP66-PLAN1-970099A1\",\"requestDate\":\"2026-04-08 02:37:10\",\"status\":2,\"subject\":\"Cobro inicial plan por registro Básico Pyme (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"soledadmellazuniga@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-08 02:38:24\",\"media\":\"Webpay\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-09 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-08 02:38:26'),
(274, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 02:40:33'),
(275, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 02:40:34'),
(276, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 02:40:35'),
(280, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', '29BDF26F1AA8EAEB88F6DAAC45153781D12A9F5G', '{\"flowOrder\":165613397,\"commerceOrder\":\"EMP67-PLAN1-BDE60F7E\",\"requestDate\":\"2026-04-08 02:40:35\",\"status\":3,\"subject\":\"Cobro inicial plan por registro Básico Pyme (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"pablitoislamella@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 02:42:01'),
(281, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 03:38:51'),
(282, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 03:38:51'),
(283, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Pyme Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-07 20:28:10\",\"delete_userId\":323345}', '2026-04-08 03:38:52'),
(286, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', 'FE8FBBA3EAAFBD1674F4832938E884686F69674C', '{\"flowOrder\":165616168,\"commerceOrder\":\"EMP68-PLAN1-23A33139\",\"requestDate\":\"2026-04-08 03:38:53\",\"status\":2,\"subject\":\"Cobro inicial plan por registro Básico Pyme (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"erwin.2785@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-08 03:40:31\",\"media\":\"Webpay\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-09 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-08 03:40:33'),
(288, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-08 03:49:22'),
(289, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-08 03:49:23'),
(290, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'PROFESIONAL_MENSUAL', '{\"planId\":\"PROFESIONAL_MENSUAL\",\"name\":\"Profesional Emprende Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:09:29\",\"periods_number\":1,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:09:29\",\"updated_at\":\"2026-04-08 03:49:23\",\"delete_userId\":323345}', '2026-04-08 03:49:24'),
(291, 69, NULL, 'pago', 'info', 'Pago único creado en Flow', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"token\":\"DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":165616534}', '2026-04-08 03:49:24'),
(292, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:52:35'),
(293, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:52:39'),
(294, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:52:40'),
(295, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:52:43'),
(296, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:52:45'),
(297, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:52:46'),
(298, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:09'),
(299, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:11'),
(300, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:14'),
(301, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:16'),
(302, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:18'),
(303, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:20'),
(304, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:23'),
(305, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:26'),
(306, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:29'),
(307, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:31'),
(308, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:35'),
(309, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:37'),
(310, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:39'),
(311, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:41'),
(312, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":1,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-08 03:53:42'),
(313, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":2,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-08 03:53:44\",\"media\":\"Webpay\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-09 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-08 03:53:44'),
(314, 69, NULL, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":2,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-08 03:53:44\",\"media\":\"Webpay\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-09 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-08 03:53:46'),
(315, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":2,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-08 03:53:44\",\"media\":\"Webpay\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-09 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-08 03:53:46'),
(316, 69, 1, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":2,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-08 03:53:44\",\"media\":\"Webpay\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-09 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-08 03:53:46'),
(317, 69, NULL, 'pago', 'info', 'Estado de pago sincronizado', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":2,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-08 03:53:44\",\"media\":\"Webpay\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-09 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-08 03:53:49'),
(318, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-10 02:06:27'),
(319, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-10 02:06:28'),
(320, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_ANUAL', '{\"planId\":\"BASICO_ANUAL\",\"name\":\"Básico Emprende Anual\",\"currency\":\"CLP\",\"amount\":\"132498\",\"interval\":4,\"interval_count\":1,\"created\":\"2026-04-06 12:36:40\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:36:40\",\"updated_at\":\"2026-04-10 02:06:28\",\"delete_userId\":323345}', '2026-04-10 02:06:29'),
(323, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', '3F7F47F83F9BBEBAD071328261EA85D2FA5C878C', '{\"flowOrder\":165799974,\"commerceOrder\":\"EMP70-PLAN1-E01A571A\",\"requestDate\":\"2026-04-10 02:06:29\",\"status\":3,\"subject\":\"Cobro inicial plan por registro Básico Emprende (anual)\",\"currency\":\"CLP\",\"amount\":\"132498\",\"payer\":\"soledadmellazuniga@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-10 02:08:17'),
(325, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/create', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/create\",\"http_code\":401,\"response\":{\"code\":501,\"message\":\"Internal Server Error - This planId has already been used\"}}', '2026-04-11 02:06:30'),
(326, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'plans/update', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/plans\\/update\",\"http_code\":400,\"response\":{\"code\":105,\"message\":\"No services available\"}}', '2026-04-11 02:06:30'),
(327, NULL, NULL, 'plan', 'info', 'Plan sincronizado con Flow', 'BASICO_MENSUAL', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Emprende Mensual\",\"currency\":\"CLP\",\"amount\":\"12990\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":15,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-11 02:06:31\",\"delete_userId\":323345}', '2026-04-11 02:06:31'),
(329, NULL, NULL, 'api', 'error', 'Flow POST con error HTTP', 'customer/register', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/customer\\/register\",\"http_code\":400,\"response\":{\"code\":7001,\"message\":\"Commerce has not automatic charge contract\"}}', '2026-04-11 02:06:32'),
(330, 69, 1, 'pago', 'info', 'Pago único creado en Flow', '18DD692479BDEE68BCF72EF4457AB17BD3D9687R', '{\"token\":\"18DD692479BDEE68BCF72EF4457AB17BD3D9687R\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":165896142}', '2026-04-11 02:31:25'),
(331, 73, 1, 'pago', 'info', 'Pago único creado en Flow', 'DBA392B643A11411B4FDC48E3F4DE802D9E503CY', '{\"token\":\"DBA392B643A11411B4FDC48E3F4DE802D9E503CY\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":165966431}', '2026-04-11 22:50:14'),
(332, 73, 1, 'pago', 'info', 'Pago único creado en Flow', 'CDE9F0765F186BFB86963FCCD36444B4F6006C0U', '{\"token\":\"CDE9F0765F186BFB86963FCCD36444B4F6006C0U\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":165980370}', '2026-04-12 02:59:24'),
(333, 73, 1, 'pago', 'info', 'Estado de pago sincronizado', 'CDE9F0765F186BFB86963FCCD36444B4F6006C0U', '{\"flowOrder\":165980370,\"commerceOrder\":\"EMP73-PLAN3-069276C7\",\"requestDate\":\"2026-04-12 02:59:24\",\"status\":1,\"subject\":\"Activación del plan al finalizar periodo de prueba Empresa Full (mensual)\",\"currency\":\"CLP\",\"amount\":\"55000\",\"payer\":\"soledadmellazuniga@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-12 03:35:33'),
(334, 73, 1, 'pago', 'info', 'Pago único creado en Flow', '31528ACF0A7586A68B42C1FFE1FDC8C7306E3E4G', '{\"token\":\"31528ACF0A7586A68B42C1FFE1FDC8C7306E3E4G\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":166036214}', '2026-04-12 20:38:08'),
(335, NULL, NULL, 'api', 'error', 'Flow GET con error HTTP', 'payment/getStatus', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/payment\\/getStatus?apiKey=484DFD4D-0A41-424D-A573-95BDAF374LD4&token=0AF1FA46EB7B822B25EB3F0EDEB808B0A8BE92AD&s=e102cef77ff3c539633fb7a536bacdaddde37392837c9d69c76eaf4c29303e8f\",\"http_code\":400,\"response\":{\"code\":1700,\"message\":\"Transaction not found\"}}', '2026-04-15 14:58:13'),
(336, NULL, NULL, 'webhook', 'error', 'Error al procesar webhook de pago: Flow devolvió error HTTP 400: Transaction not found', '0AF1FA46EB7B822B25EB3F0EDEB808B0A8BE92AD', '{\"token\":\"0AF1FA46EB7B822B25EB3F0EDEB808B0A8BE92AD\"}', '2026-04-15 14:58:13'),
(337, NULL, NULL, 'api', 'error', 'Flow GET con error HTTP', 'payment/getStatus', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/payment\\/getStatus?apiKey=484DFD4D-0A41-424D-A573-95BDAF374LD4&token=32176B4C0667A1A5F64BBBFAC2CF487FB494C11V&s=94ad9d4aa8b50a72afa2153d6628e57f6edbfebad09162a893a4f2d7a1c2c90a\",\"http_code\":400,\"response\":{\"code\":1700,\"message\":\"Transaction not found\"}}', '2026-04-15 15:06:46');
INSERT INTO `flow_logs` (`id`, `empresa_id`, `admin_usuario_id`, `tipo`, `nivel`, `mensaje`, `referencia`, `payload`, `fecha_creacion`) VALUES
(338, NULL, NULL, 'webhook', 'warning', 'Sincronización flow_pagos omitida o con error: Flow devolvió error HTTP 400: Transaction not found', '32176B4C0667A1A5F64BBBFAC2CF487FB494C11V', '{\"token\":\"32176B4C0667A1A5F64BBBFAC2CF487FB494C11V\"}', '2026-04-15 15:06:46'),
(339, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', '32176B4C0667A1A5F64BBBFAC2CF487FB494C11V', '{\"flowOrder\":166286333,\"commerceOrder\":\"CAT-77-5FB801E254\",\"requestDate\":\"2026-04-15 15:06:14\",\"status\":2,\"subject\":\"Compra catálogo Pv SportChile\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"vicente.isla13@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-15 15:06:45\",\"media\":\"Mach\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-16 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-15 15:06:47'),
(340, NULL, NULL, 'api', 'error', 'Flow GET con error HTTP', 'payment/getStatus', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/payment\\/getStatus?apiKey=484DFD4D-0A41-424D-A573-95BDAF374LD4&token=F578CE0A71B8ABF73161EF5587F26EE0462B181Z&s=5e2568e9bdcc3daba83881665ef7f76ef51534873acbfbc07d81fa1d92c7297c\",\"http_code\":400,\"response\":{\"code\":1700,\"message\":\"Transaction not found\"}}', '2026-04-15 15:24:43'),
(341, NULL, NULL, 'webhook', 'warning', 'Sincronización flow_pagos omitida o con error: Flow devolvió error HTTP 400: Transaction not found', 'F578CE0A71B8ABF73161EF5587F26EE0462B181Z', '{\"token\":\"F578CE0A71B8ABF73161EF5587F26EE0462B181Z\"}', '2026-04-15 15:24:43'),
(342, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', 'F578CE0A71B8ABF73161EF5587F26EE0462B181Z', '{\"flowOrder\":166287909,\"commerceOrder\":\"CAT-77-CB5EC755E5\",\"requestDate\":\"2026-04-15 15:23:58\",\"status\":2,\"subject\":\"Compra catálogo Pv SportChile\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"vicente.isla13@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-15 15:24:42\",\"media\":\"Mach\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-16 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-15 15:24:44'),
(343, NULL, NULL, 'api', 'error', 'Flow GET con error HTTP', 'payment/getStatus', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/payment\\/getStatus?apiKey=484DFD4D-0A41-424D-A573-95BDAF374LD4&token=BDD42E62DF8DA87EEC1C3EA7BFCBE02E55F794CI&s=c2d6f6271932a4767d7e286cca550d29fa7cf4347fe2288b547a596e3da8d15e\",\"http_code\":400,\"response\":{\"code\":1700,\"message\":\"Transaction not found\"}}', '2026-04-15 15:57:28'),
(344, NULL, NULL, 'webhook', 'warning', 'Sincronización flow_pagos omitida o con error: Flow devolvió error HTTP 400: Transaction not found', 'BDD42E62DF8DA87EEC1C3EA7BFCBE02E55F794CI', '{\"token\":\"BDD42E62DF8DA87EEC1C3EA7BFCBE02E55F794CI\"}', '2026-04-15 15:57:28'),
(345, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', 'BDD42E62DF8DA87EEC1C3EA7BFCBE02E55F794CI', '{\"flowOrder\":166291787,\"commerceOrder\":\"CAT-77-409B3C4D32\",\"requestDate\":\"2026-04-15 15:57:00\",\"status\":2,\"subject\":\"Compra catálogo Pv SportChile\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"vicente.isla13@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-15 15:57:26\",\"media\":\"Mach\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-16 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-15 15:57:28'),
(346, NULL, NULL, 'api', 'error', 'Flow GET con error HTTP', 'payment/getStatus', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/payment\\/getStatus?apiKey=484DFD4D-0A41-424D-A573-95BDAF374LD4&token=EC0F3BE256BEEBD88CA2AA009DE0216F47B85CBC&s=4049ded47cc972daeb6b313ed99f17e1bea87b62662d41fb8897ca3b77618dc5\",\"http_code\":400,\"response\":{\"code\":1700,\"message\":\"Transaction not found\"}}', '2026-04-15 16:07:44'),
(347, NULL, NULL, 'webhook', 'warning', 'Sincronización flow_pagos omitida o con error: Flow devolvió error HTTP 400: Transaction not found', 'EC0F3BE256BEEBD88CA2AA009DE0216F47B85CBC', '{\"token\":\"EC0F3BE256BEEBD88CA2AA009DE0216F47B85CBC\"}', '2026-04-15 16:07:44'),
(348, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', 'EC0F3BE256BEEBD88CA2AA009DE0216F47B85CBC', '{\"flowOrder\":166293053,\"commerceOrder\":\"CAT-77-6B25CEA4A1\",\"requestDate\":\"2026-04-15 16:06:57\",\"status\":2,\"subject\":\"Compra catálogo Pv SportChile\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"vicente.isla13@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-15 16:07:43\",\"media\":\"Mach\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-16 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-15 16:07:45'),
(349, NULL, NULL, 'api', 'error', 'Flow GET con error HTTP', 'payment/getStatus', '{\"url\":\"https:\\/\\/www.flow.cl\\/api\\/payment\\/getStatus?apiKey=484DFD4D-0A41-424D-A573-95BDAF374LD4&token=366BA514FBAF6D8E7FA4488EF9952C9EECFE097K&s=53fb7c1e93e4dc24743070cce239345ddf26203f7276686a93c56800074b8c6f\",\"http_code\":400,\"response\":{\"code\":1700,\"message\":\"Transaction not found\"}}', '2026-04-16 23:06:53'),
(350, NULL, NULL, 'webhook', 'warning', 'Sincronización flow_pagos omitida o con error: Flow devolvió error HTTP 400: Transaction not found', '366BA514FBAF6D8E7FA4488EF9952C9EECFE097K', '{\"token\":\"366BA514FBAF6D8E7FA4488EF9952C9EECFE097K\"}', '2026-04-16 23:06:53'),
(351, NULL, NULL, 'webhook', 'info', 'Webhook pago procesado', '366BA514FBAF6D8E7FA4488EF9952C9EECFE097K', '{\"flowOrder\":166455340,\"commerceOrder\":\"CAT-77-9BA71F0B27\",\"requestDate\":\"2026-04-16 23:06:18\",\"status\":2,\"subject\":\"Compra catálogo Pv SportChile\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"vicente.isla13@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-16 23:06:51\",\"media\":\"Mach\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-17 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-16 23:06:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `flow_pagos`
--

CREATE TABLE `flow_pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `pago_id` bigint UNSIGNED DEFAULT NULL,
  `suscripcion_id` bigint UNSIGNED DEFAULT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `plan_id` bigint UNSIGNED DEFAULT NULL,
  `tipo_pago` enum('unico','recurrente') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unico',
  `commerce_order` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flow_token` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flow_order` bigint DEFAULT NULL,
  `flow_payment_id` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado_local` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `estado_flow` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monto` decimal(12,2) NOT NULL,
  `moneda` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CLP',
  `entorno_flow` enum('sandbox','produccion') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `fecha_confirmacion` datetime DEFAULT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `payload_request` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `payload_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `flow_pagos`
--

INSERT INTO `flow_pagos` (`id`, `pago_id`, `suscripcion_id`, `empresa_id`, `plan_id`, `tipo_pago`, `commerce_order`, `flow_token`, `flow_order`, `flow_payment_id`, `estado_local`, `estado_flow`, `monto`, `moneda`, `entorno_flow`, `fecha_confirmacion`, `observaciones`, `payload_request`, `payload_response`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(35, 35, 50, 69, 2, 'unico', 'EMP69-PLAN2-3C4DAF08', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', 165616534, '165616534', 'aprobado', '2', 500.00, 'CLP', 'produccion', '2026-04-08 02:53:49', 'Sincronizado con Flow (2026-04-08 02:53:49)', '{\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":500,\"email\":\"javigonzalez2024@udec.cl\",\"urlConfirmation\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/payment-confirmation\",\"urlReturn\":\"https:\\/\\/vextra.cl\\/retorno\\/pago?origen=registro\"}', '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":2,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-08 03:53:44\",\"media\":\"Webpay\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-09 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-08 03:49:24', '2026-04-08 03:53:49'),
(37, 37, 50, 69, 2, 'unico', 'EMP69-PLAN2-9F442C36', '18DD692479BDEE68BCF72EF4457AB17BD3D9687R', NULL, NULL, 'pendiente', 'created', 17000.00, 'CLP', 'produccion', NULL, 'Pendiente confirmación oficial Flow', '{\"commerceOrder\":\"EMP69-PLAN2-9F442C36\",\"subject\":\"Activación del plan al finalizar periodo de prueba Profesional Crecimiento (mensual)\",\"currency\":\"CLP\",\"amount\":17000,\"email\":\"vextracl@gmail.com\",\"urlConfirmation\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/payment-confirmation\",\"urlReturn\":\"https:\\/\\/vextra.cl\\/retorno\\/pago?origen=trial_pago\"}', '{\"token\":\"18DD692479BDEE68BCF72EF4457AB17BD3D9687R\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":165896142}', '2026-04-11 02:31:25', NULL),
(38, 38, 54, 73, 3, 'unico', 'EMP73-PLAN3-8CB713CC', 'DBA392B643A11411B4FDC48E3F4DE802D9E503CY', NULL, NULL, 'pendiente', 'created', 55000.00, 'CLP', 'produccion', NULL, 'Pendiente confirmación oficial Flow', '{\"commerceOrder\":\"EMP73-PLAN3-8CB713CC\",\"subject\":\"Activación del plan al finalizar periodo de prueba Empresa Full (mensual)\",\"currency\":\"CLP\",\"amount\":55000,\"email\":\"soledadmellazuniga@gmail.com\",\"urlConfirmation\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/payment-confirmation\",\"urlReturn\":\"https:\\/\\/vextra.cl\\/retorno\\/pago?origen=trial_pago\"}', '{\"token\":\"DBA392B643A11411B4FDC48E3F4DE802D9E503CY\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":165966431}', '2026-04-11 22:50:14', NULL),
(39, 39, 54, 73, 3, 'unico', 'EMP73-PLAN3-069276C7', 'CDE9F0765F186BFB86963FCCD36444B4F6006C0U', 165980370, '165980370', 'pendiente', '1', 55000.00, 'CLP', 'produccion', NULL, 'Sincronizado con Flow (2026-04-12 02:35:33)', '{\"commerceOrder\":\"EMP73-PLAN3-069276C7\",\"subject\":\"Activación del plan al finalizar periodo de prueba Empresa Full (mensual)\",\"currency\":\"CLP\",\"amount\":55000,\"email\":\"soledadmellazuniga@gmail.com\",\"urlConfirmation\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/payment-confirmation\",\"urlReturn\":\"https:\\/\\/vextra.cl\\/retorno\\/pago?origen=trial_pago\"}', '{\"flowOrder\":165980370,\"commerceOrder\":\"EMP73-PLAN3-069276C7\",\"requestDate\":\"2026-04-12 02:59:24\",\"status\":1,\"subject\":\"Activación del plan al finalizar periodo de prueba Empresa Full (mensual)\",\"currency\":\"CLP\",\"amount\":\"55000\",\"payer\":\"soledadmellazuniga@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-12 02:59:24', '2026-04-12 03:35:33'),
(40, 40, 54, 73, 1, 'unico', 'EMP73-PLAN1-BA9894B9', '31528ACF0A7586A68B42C1FFE1FDC8C7306E3E4G', NULL, NULL, 'pendiente', 'created', 132498.00, 'CLP', 'produccion', NULL, 'Pendiente confirmación oficial Flow', '{\"commerceOrder\":\"EMP73-PLAN1-BA9894B9\",\"subject\":\"Cambio de plan y reactivación de cuenta vencida Básico Emprende (anual)\",\"currency\":\"CLP\",\"amount\":132498,\"email\":\"soledadmellazuniga@gmail.com\",\"urlConfirmation\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/payment-confirmation\",\"urlReturn\":\"https:\\/\\/vextra.cl\\/retorno\\/pago?origen=trial_pago\"}', '{\"token\":\"31528ACF0A7586A68B42C1FFE1FDC8C7306E3E4G\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":166036214}', '2026-04-12 20:38:08', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `flow_planes`
--

CREATE TABLE `flow_planes` (
  `id` bigint UNSIGNED NOT NULL,
  `plan_id` bigint UNSIGNED NOT NULL,
  `modalidad` enum('mensual','anual') COLLATE utf8mb4_unicode_ci NOT NULL,
  `flow_plan_id` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `moneda` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CLP',
  `monto` decimal(12,2) NOT NULL,
  `intervalo` smallint NOT NULL DEFAULT '3',
  `intervalo_cantidad` smallint NOT NULL DEFAULT '1',
  `dias_trial` smallint NOT NULL DEFAULT '0',
  `dias_vencimiento` smallint NOT NULL DEFAULT '3',
  `periodos` smallint DEFAULT NULL,
  `estado_local` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `estado_flow` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entorno_flow` enum('sandbox','produccion') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `payload_request` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `payload_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `flow_planes`
--

INSERT INTO `flow_planes` (`id`, `plan_id`, `modalidad`, `flow_plan_id`, `moneda`, `monto`, `intervalo`, `intervalo_cantidad`, `dias_trial`, `dias_vencimiento`, `periodos`, `estado_local`, `estado_flow`, `entorno_flow`, `payload_request`, `payload_response`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 1, 'mensual', 'BASICO_MENSUAL', 'CLP', 12990.00, 3, 1, 15, 3, 1, 'activo', 'activo', 'produccion', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Emprende Mensual\",\"currency\":\"CLP\",\"amount\":12990,\"interval\":3,\"interval_count\":1,\"trial_period_days\":15,\"days_until_due\":3,\"periods_number\":1,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1}', '{\"planId\":\"BASICO_MENSUAL\",\"name\":\"Básico Emprende Mensual\",\"currency\":\"CLP\",\"amount\":\"12990\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:04:10\",\"periods_number\":1,\"trial_period_days\":15,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:04:10\",\"updated_at\":\"2026-04-11 02:06:31\",\"delete_userId\":323345}', '2026-04-07 17:42:25', '2026-04-11 02:06:31'),
(2, 1, 'anual', 'BASICO_ANUAL', 'CLP', 132498.00, 4, 1, 0, 3, 1, 'activo', 'activo', 'produccion', '{\"planId\":\"BASICO_ANUAL\",\"name\":\"Básico Emprende Anual\",\"currency\":\"CLP\",\"amount\":132498,\"interval\":4,\"interval_count\":1,\"trial_period_days\":0,\"days_until_due\":3,\"periods_number\":1,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1}', '{\"planId\":\"BASICO_ANUAL\",\"name\":\"Básico Emprende Anual\",\"currency\":\"CLP\",\"amount\":\"132498\",\"interval\":4,\"interval_count\":1,\"created\":\"2026-04-06 12:36:40\",\"periods_number\":1,\"trial_period_days\":5,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:36:40\",\"updated_at\":\"2026-04-10 02:06:28\",\"delete_userId\":323345}', '2026-04-07 19:24:32', '2026-04-10 02:06:29'),
(3, 2, 'mensual', 'PROFESIONAL_MENSUAL', 'CLP', 500.00, 3, 1, 0, 3, 1, 'activo', 'activo', 'produccion', '{\"planId\":\"PROFESIONAL_MENSUAL\",\"name\":\"Profesional Emprende Mensual\",\"currency\":\"CLP\",\"amount\":500,\"interval\":3,\"interval_count\":1,\"trial_period_days\":0,\"days_until_due\":3,\"periods_number\":1,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1}', '{\"planId\":\"PROFESIONAL_MENSUAL\",\"name\":\"Profesional Emprende Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-06 12:09:29\",\"periods_number\":1,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":0,\"public\":0,\"created_at\":\"2026-04-06 12:09:29\",\"updated_at\":\"2026-04-08 03:49:23\",\"delete_userId\":323345}', '2026-04-07 19:27:23', '2026-04-08 03:49:24'),
(4, 2, 'anual', 'PROFESIONAL_ANUAL', 'CLP', 500.00, 4, 1, 0, 3, 1, 'activo', 'activo', 'produccion', '{\"planId\":\"PROFESIONAL_ANUAL\",\"name\":\"Profesional Emprende Anual\",\"currency\":\"CLP\",\"amount\":500,\"interval\":4,\"interval_count\":1,\"trial_period_days\":0,\"days_until_due\":3,\"periods_number\":1,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1}', '{\"status\":\"already_exists\",\"planId\":\"PROFESIONAL_ANUAL\",\"message\":\"El plan ya existía en Flow; no fue posible ejecutar update automático.\"}', '2026-04-07 19:27:25', '2026-04-08 01:09:32'),
(5, 3, 'mensual', 'EMPRESA_MENSUAL', 'CLP', 500.00, 3, 1, 0, 3, 1, 'activo', 'activo', 'produccion', '{\"planId\":\"EMPRESA_MENSUAL\",\"name\":\"Empresa Mensual\",\"currency\":\"CLP\",\"amount\":500,\"interval\":3,\"interval_count\":1,\"trial_period_days\":0,\"days_until_due\":3,\"periods_number\":1,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1}', '{\"planId\":\"EMPRESA_MENSUAL\",\"name\":\"Empresa Mensual\",\"currency\":\"CLP\",\"amount\":\"500\",\"interval\":3,\"interval_count\":1,\"created\":\"2026-04-07 19:27:34\",\"periods_number\":1,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":1,\"public\":0,\"created_at\":\"2026-04-07 19:27:34\",\"updated_at\":\"2026-04-07 20:27:52\",\"delete_userId\":null}', '2026-04-07 19:27:34', '2026-04-07 20:27:52'),
(6, 3, 'anual', 'EMPRESA_ANUAL', 'CLP', 561000.00, 4, 1, 0, 3, 1, 'activo', 'activo', 'produccion', '{\"planId\":\"EMPRESA_ANUAL\",\"name\":\"Empresa Anual\",\"currency\":\"CLP\",\"amount\":561000,\"interval\":4,\"interval_count\":1,\"trial_period_days\":0,\"days_until_due\":3,\"periods_number\":1,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1}', '{\"planId\":\"EMPRESA_ANUAL\",\"name\":\"Empresa Anual\",\"currency\":\"CLP\",\"amount\":\"561000\",\"interval\":4,\"interval_count\":1,\"created\":\"2026-04-07 19:27:37\",\"periods_number\":1,\"trial_period_days\":0,\"days_until_due\":3,\"urlCallback\":\"https:\\/\\/vextra.cl\\/flow\\/webhook\\/subscription\",\"charges_retries_number\":3,\"currency_convert_option\":1,\"status\":1,\"public\":0,\"created_at\":\"2026-04-07 19:27:37\",\"updated_at\":\"2026-04-07 20:27:56\",\"delete_userId\":null}', '2026-04-07 19:27:37', '2026-04-07 20:27:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `flow_suscripciones`
--

CREATE TABLE `flow_suscripciones` (
  `id` bigint UNSIGNED NOT NULL,
  `suscripcion_id` bigint UNSIGNED DEFAULT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `plan_id` bigint UNSIGNED NOT NULL,
  `flow_customer_id` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flow_plan_id` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flow_subscription_id` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_cobro` enum('mensual','anual') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'mensual',
  `estado_local` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `estado_flow` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entorno_flow` enum('sandbox','produccion') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sandbox',
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_vencimiento` datetime DEFAULT NULL,
  `proxima_renovacion` datetime DEFAULT NULL,
  `fecha_cancelacion` datetime DEFAULT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `payload_request` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `payload_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `flow_webhooks`
--

CREATE TABLE `flow_webhooks` (
  `id` bigint UNSIGNED NOT NULL,
  `tipo_evento` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hash_unico` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `procesado` tinyint(1) NOT NULL DEFAULT '0',
  `resultado` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `error_detalle` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_procesamiento` datetime DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `flow_webhooks`
--

INSERT INTO `flow_webhooks` (`id`, `tipo_evento`, `token`, `hash_unico`, `payload`, `procesado`, `resultado`, `error_detalle`, `fecha_creacion`, `fecha_procesamiento`) VALUES
(1, 'payment_confirmation', 'F38CAB817FC42EE777F8B902AFE5BA012EC7904I', '237675ba90fce94290c3818bb2038bcccc7e318732e6f7db7b5ab1ec8ec09faf', '{\"token\":\"F38CAB817FC42EE777F8B902AFE5BA012EC7904I\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-07 19:44:03', '2026-04-07 19:44:04'),
(2, 'payment_confirmation', 'EFCF8F70CFFC8CE4AE5DBC0B535219058A51D05C', '3cdb86ace931406469351dea0b70d73d7735e90c3310284a07ef859fb18b438d', '{\"token\":\"EFCF8F70CFFC8CE4AE5DBC0B535219058A51D05C\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-07 19:52:22', '2026-04-07 19:52:23'),
(3, 'payment_confirmation', '5071D5FDC1EFB0CB1EAAC99E6E879629FBAF7D4K', '7546f6f5d4fa6df08ca8e59b74d82e3b13e6608239b0740a3a883ad3cf2ca4e4', '{\"token\":\"5071D5FDC1EFB0CB1EAAC99E6E879629FBAF7D4K\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-07 20:06:18', '2026-04-07 20:06:18'),
(4, 'payment_confirmation', 'A847FF03239B6315A52B6DF16DCD085268F2240D', '68c19adcb1136f68b67c34c8717377f6c3a7494d545b57fe09588522546d8624', '{\"token\":\"A847FF03239B6315A52B6DF16DCD085268F2240D\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-07 22:21:17', '2026-04-07 22:21:18'),
(5, 'payment_confirmation', 'A21FA7BC0F26027B8B6963FCD5C155373D8D5B5V', '82e69ed075e724230fd0778222e1c7f8ab393b516cadb395773261159e800171', '{\"token\":\"A21FA7BC0F26027B8B6963FCD5C155373D8D5B5V\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-07 22:36:04', '2026-04-07 22:36:05'),
(6, 'payment_confirmation', '3285B2477BE7D81FB30E8855B1C144C0073DA40O', '616492fd287eccd7f906e1939581034a3b3a6e77698261f3a8013f9200e89209', '{\"token\":\"3285B2477BE7D81FB30E8855B1C144C0073DA40O\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-07 23:07:28', '2026-04-07 23:07:28'),
(7, 'payment_confirmation', '73BA8C7BDFCE6E8CC5BFFDFFFA58537A3966876T', '99f7ae37f8ad575832d4bdd8a92d7507adb4370fd96737c77fd6a8eb5d9043c8', '{\"token\":\"73BA8C7BDFCE6E8CC5BFFDFFFA58537A3966876T\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-07 23:19:14', '2026-04-07 23:19:14'),
(8, 'payment_confirmation', '8F0DB6369062C0476D9D36BBE33B88BA46C654FA', 'bdad40b3d06f076f7ed1003036cfea777d31b08fce8d5c46993a7f34d7930755', '{\"token\":\"8F0DB6369062C0476D9D36BBE33B88BA46C654FA\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-07 23:28:02', '2026-04-07 23:28:02'),
(9, 'payment_confirmation', '54CFE497E6F45F645F0CAD9928FCE34117795ABQ', '689c43f46cf0053d9ce6981576959ed76330050ec4d281630eaac56c7e144f79', '{\"token\":\"54CFE497E6F45F645F0CAD9928FCE34117795ABQ\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-08 00:10:12', '2026-04-08 00:10:12'),
(10, 'payment_confirmation', 'A3A9C84C2805BC5E8FA14E62C8074CC5B4A7C2FQ', '118ed2d50e4bf3434d05b17b4f19fcb6798c69b907c1a11a8f5eb18b49891e65', '{\"token\":\"A3A9C84C2805BC5E8FA14E62C8074CC5B4A7C2FQ\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-08 00:27:58', '2026-04-08 00:27:59'),
(11, 'payment_confirmation', 'C9356948F49E06CCF3F9BE2E54F94E70F651A23R', '8541beb0dc6264f1ce9f08e7a7cb1eb0a604c556b071da1f00c11ecb9fa3cfbb', '{\"token\":\"C9356948F49E06CCF3F9BE2E54F94E70F651A23R\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-08 00:41:19', '2026-04-08 00:41:19'),
(12, 'payment_confirmation', 'C4783730C74DE548DF266F72AD53D471067C71EQ', 'ade29514dc0022c8eb7562e168f1707c15317aaabb855a489d34b7f375a81cf7', '{\"token\":\"C4783730C74DE548DF266F72AD53D471067C71EQ\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-08 00:47:24', '2026-04-08 00:47:25'),
(13, 'payment_confirmation', '59D5E2718378D569FBBDF7F72FA2F214C10941DT', '873f3dd54b7193be5d3b5172a5481f4f3c9f0904c8afbeabc12822c59c5f2027', '{\"token\":\"59D5E2718378D569FBBDF7F72FA2F214C10941DT\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-08 00:57:15', '2026-04-08 00:57:16'),
(14, 'payment_confirmation', '030BEA964AD80F38EDF2FCF153DF8B5A6A1CC72V', '792015cf7a8d89329ab95a4a389e087ecb77252a3b9bb7e93f13cf28fc873981', '{\"token\":\"030BEA964AD80F38EDF2FCF153DF8B5A6A1CC72V\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-08 01:10:19', '2026-04-08 01:10:20'),
(15, 'payment_confirmation', 'DC500CF15928DF1FA87E6D944EFB7786DCA55FCO', '07a17925d02251dc56821f7e2fae9b744cc7c7d573d8696a36c471d912cda73f', '{\"token\":\"DC500CF15928DF1FA87E6D944EFB7786DCA55FCO\"}', 1, 'error', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'fecha_actualizacion\' in \'field list\'', '2026-04-08 01:19:12', '2026-04-08 01:19:13'),
(16, 'payment_confirmation', '4B4F6AED73C0F76A17B419728D156F12A5EA267C', 'ddc511178cc3e7c3375b75d9901e4de06dfc511024788ecb74598290f797a6d9', '{\"token\":\"4B4F6AED73C0F76A17B419728D156F12A5EA267C\"}', 1, 'ok', NULL, '2026-04-08 01:28:45', '2026-04-08 01:28:46'),
(17, 'payment_confirmation', 'EFFC9B48BA73EEE88E7016BFB632EE631281782B', '6b706592fa5496d128f351805e87f416d31d6c11b8d447b89ed5cea63338c314', '{\"token\":\"EFFC9B48BA73EEE88E7016BFB632EE631281782B\"}', 1, 'ok', NULL, '2026-04-08 01:35:46', '2026-04-08 01:35:47'),
(18, 'payment_confirmation', '3D9B4ED607F9D10F31B7A476BAEEE87511A30E9O', '126c63b41382387de7139b57f245cd666b28bcae46da0b60237ba67166b0d2f6', '{\"token\":\"3D9B4ED607F9D10F31B7A476BAEEE87511A30E9O\"}', 1, 'ok', NULL, '2026-04-08 01:51:39', '2026-04-08 01:51:40'),
(19, 'payment_confirmation', 'FBF8960AD8D574906CC51F94B178EFC18838721U', 'b2b5853bfafa01f98a56b84030acd0246bd73568ed932fac90dbb919e4f4e9ac', '{\"token\":\"FBF8960AD8D574906CC51F94B178EFC18838721U\"}', 1, 'ok', NULL, '2026-04-08 01:58:21', '2026-04-08 01:58:21'),
(20, 'payment_confirmation', 'E53D9F1723D77A6E6DE9EDA0C51D6426C41B637E', 'bfffdc787718c17e45cf077e6a05ae49343765be162901f9fbb66f1404eb4cfd', '{\"token\":\"E53D9F1723D77A6E6DE9EDA0C51D6426C41B637E\"}', 1, 'ok', NULL, '2026-04-08 02:02:18', '2026-04-08 02:02:19'),
(21, 'payment_confirmation', '0A18D11396718AB35FA5F7C8AF6DD51190E3C58T', 'f30da8045eb6437ef139954df5eebcd743ce3c36fdffa5a6fe5f8b2e0c8a1d73', '{\"token\":\"0A18D11396718AB35FA5F7C8AF6DD51190E3C58T\"}', 1, 'ok', NULL, '2026-04-08 02:35:24', '2026-04-08 02:35:25'),
(22, 'payment_confirmation', 'E2B2124310115F3FDFDBA3D0E42D0AB63891D3AO', 'df4a006f72c0dced19430f16e373399bffef3c0d52ebb3f4f0acf2223b6f99ad', '{\"token\":\"E2B2124310115F3FDFDBA3D0E42D0AB63891D3AO\"}', 1, 'ok', NULL, '2026-04-08 02:38:25', '2026-04-08 02:38:26'),
(23, 'payment_confirmation', '29BDF26F1AA8EAEB88F6DAAC45153781D12A9F5G', '7ec080c13384f6c03ba464e57359804e2b10c1d422fa93ed8eb066839fe919a7', '{\"token\":\"29BDF26F1AA8EAEB88F6DAAC45153781D12A9F5G\"}', 1, 'ok', NULL, '2026-04-08 02:42:01', '2026-04-08 02:42:01'),
(24, 'payment_confirmation', 'FE8FBBA3EAAFBD1674F4832938E884686F69674C', 'b4950054fb5877460cdc882bf46c339c0194abc94358aca938801f6892c348dc', '{\"token\":\"FE8FBBA3EAAFBD1674F4832938E884686F69674C\"}', 1, 'ok', NULL, '2026-04-08 03:40:32', '2026-04-08 03:40:33'),
(25, 'payment_confirmation', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '7e4034d5f6b63678a0d10f3464d6bf8105e4f4f849a771a37c2c41b82436203c', '{\"token\":\"DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J\"}', 1, 'ok', NULL, '2026-04-08 03:53:45', '2026-04-08 03:53:46'),
(26, 'payment_confirmation', '3F7F47F83F9BBEBAD071328261EA85D2FA5C878C', '0d2de52214803781e8a6652a0cd2fe074c2fbeb39fb71b90f2ea545f1be1ebb7', '{\"token\":\"3F7F47F83F9BBEBAD071328261EA85D2FA5C878C\"}', 1, 'ok', NULL, '2026-04-10 02:08:16', '2026-04-10 02:08:17'),
(27, 'payment_confirmation', '0AF1FA46EB7B822B25EB3F0EDEB808B0A8BE92AD', 'dc1f18ab8388e45b7c0013936a847e5d783c327550d249257602d8957a588746', '{\"token\":\"0AF1FA46EB7B822B25EB3F0EDEB808B0A8BE92AD\"}', 1, 'error', 'Flow devolvió error HTTP 400: Transaction not found', '2026-04-15 14:58:13', '2026-04-15 14:58:13'),
(28, 'payment_confirmation', '32176B4C0667A1A5F64BBBFAC2CF487FB494C11V', '34516a696ef48a5602c6a11334382e0f6c52c9b20e17aaa109e56dd3822928cd', '{\"token\":\"32176B4C0667A1A5F64BBBFAC2CF487FB494C11V\"}', 1, 'ok', NULL, '2026-04-15 15:06:45', '2026-04-15 15:06:47'),
(29, 'payment_confirmation', 'F578CE0A71B8ABF73161EF5587F26EE0462B181Z', '0f92840877718c472bc772cd2c897a6290627a2ff2efbd0afe0b2663391a5f46', '{\"token\":\"F578CE0A71B8ABF73161EF5587F26EE0462B181Z\"}', 1, 'ok', NULL, '2026-04-15 15:24:43', '2026-04-15 15:24:44'),
(30, 'payment_confirmation', 'BDD42E62DF8DA87EEC1C3EA7BFCBE02E55F794CI', 'b289f05b99247a31acf65135026da358244ab3366c586907e7f7d5e4a0204a30', '{\"token\":\"BDD42E62DF8DA87EEC1C3EA7BFCBE02E55F794CI\"}', 1, 'ok', NULL, '2026-04-15 15:57:27', '2026-04-15 15:57:28'),
(31, 'payment_confirmation', 'EC0F3BE256BEEBD88CA2AA009DE0216F47B85CBC', '947700f4b0996d029df59960eadf464a7f2ebe8b5c0902eaafd504f547319e62', '{\"token\":\"EC0F3BE256BEEBD88CA2AA009DE0216F47B85CBC\"}', 1, 'ok', NULL, '2026-04-15 16:07:44', '2026-04-15 16:07:45'),
(32, 'payment_confirmation', '366BA514FBAF6D8E7FA4488EF9952C9EECFE097K', 'ace707c65b6a50f3136d59d02e36bec07201b3b5003d1e77682ee2bb8f692265', '{\"token\":\"366BA514FBAF6D8E7FA4488EF9952C9EECFE097K\"}', 1, 'ok', NULL, '2026-04-16 23:06:52', '2026-04-16 23:06:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `funcionalidades`
--

CREATE TABLE `funcionalidades` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_interno` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `tipo_valor` enum('booleano','numerico','ilimitado') COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` enum('activo','inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `funcionalidades`
--

INSERT INTO `funcionalidades` (`id`, `nombre`, `codigo_interno`, `descripcion`, `tipo_valor`, `estado`, `fecha_creacion`, `fecha_actualizacion`, `fecha_eliminacion`) VALUES
(1, 'Máximo usuarios', 'maximo_usuarios', 'Límite de usuarios por empresa', 'numerico', 'activo', '2026-04-07 01:23:58', '2026-04-07 01:34:34', NULL),
(2, 'Máximo clientes', 'maximo_clientes', 'Límite de clientes por empresa', 'numerico', 'activo', '2026-04-07 01:23:58', '2026-04-07 01:34:34', NULL),
(3, 'Máximo productos', 'maximo_productos', 'Límite de productos por empresa', 'numerico', 'activo', '2026-04-07 01:23:58', '2026-04-07 01:34:34', NULL),
(4, 'Máximo cotizaciones mes', 'maximo_cotizaciones_mes', 'Límite mensual de cotizaciones', 'numerico', 'activo', '2026-04-07 01:23:58', '2026-04-07 01:34:34', NULL),
(5, 'Cotización PDF', 'cotizacion_pdf', 'Permite generar PDF', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-07 01:34:34', NULL),
(6, 'Cotización por correo', 'cotizacion_correo', 'Permite enviar por correo', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-07 01:34:34', NULL),
(7, 'Logo personalizado', 'logo_personalizado', 'Permite subir logo', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-07 01:34:34', NULL),
(8, 'Reportes', 'reportes', 'Acceso a reportes avanzados', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-07 01:34:34', NULL),
(9, 'Plantillas personalizadas', 'plantillas_personalizadas', 'Permite personalización de plantillas', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-07 01:34:34', NULL),
(10, 'Acceso API', 'acceso_api', 'Habilita API', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-07 01:34:34', NULL),
(11, 'Soporte prioritario', 'soporte_prioritario', 'Soporte preferencial', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-07 01:34:34', NULL),
(12, 'Módulo clientes', 'modulo_clientes', 'Gestión de clientes y sus datos comerciales.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(13, 'Módulo productos', 'modulo_productos', 'Catálogo de productos y servicios con soporte de carga masiva.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(14, 'Módulo cotizaciones', 'modulo_cotizaciones', 'Creación, envío y seguimiento de cotizaciones.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(15, 'Módulo POS', 'modulo_pos', 'Punto de venta para registrar ventas y movimientos de caja.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(16, 'Módulo inventario', 'modulo_inventario', 'Inventario base con proveedores y control de stock.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(17, 'Módulo recepciones', 'modulo_recepciones', 'Recepciones de mercadería asociadas a inventario.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(18, 'Módulo ajustes', 'modulo_ajustes', 'Ajustes manuales de inventario por diferencias operativas.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(19, 'Módulo movimientos', 'modulo_movimientos', 'Historial de movimientos de stock y trazabilidad.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(20, 'Módulo vendedores', 'modulo_vendedores', 'Gestión de vendedores y asignación comercial.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(21, 'Módulo reportes', 'modulo_reportes', 'Reportes de ventas, inventario y desempeño comercial.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(22, 'Módulo listas de precios', 'modulo_listas_precios', 'Listas de precios por canal, cliente o condición comercial.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(23, 'Módulo órdenes de compra', 'modulo_ordenes_compra', 'Gestión de órdenes de compra a proveedores.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(24, 'Módulo usuarios', 'modulo_usuarios', 'Gestión de usuarios internos y permisos.', 'booleano', 'activo', '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(25, 'Módulo contactos', 'modulo_contactos', 'Gestión de contactos comerciales vinculados a clientes.', 'booleano', 'activo', '2026-04-07 01:34:34', '2026-04-14 00:45:18', NULL),
(26, 'Módulo categorías', 'modulo_categorias', 'Clasificación de productos por categorías.', 'booleano', 'activo', '2026-04-07 01:34:34', '2026-04-14 00:45:18', NULL),
(27, 'Módulo seguimiento', 'modulo_seguimiento', 'Seguimiento de oportunidades y actividades comerciales.', 'booleano', 'activo', '2026-04-07 01:34:34', '2026-04-14 00:45:18', NULL),
(28, 'Módulo aprobaciones', 'modulo_aprobaciones', 'Flujos de aprobación para operaciones comerciales.', 'booleano', 'activo', '2026-04-07 01:34:34', '2026-04-14 00:45:18', NULL),
(29, 'Módulo documentos', 'modulo_documentos', 'Gestión de plantillas y documentos comerciales.', 'booleano', 'activo', '2026-04-07 01:34:34', '2026-04-14 00:45:18', NULL),
(30, 'Módulo configuración', 'modulo_configuracion', 'Configuración general de la empresa.', 'booleano', 'activo', '2026-04-07 01:34:34', '2026-04-14 00:45:18', NULL),
(31, 'Módulo correos stock', 'modulo_correos_stock', 'Alertas y configuración de correos de stock.', 'booleano', 'activo', '2026-04-07 01:34:34', '2026-04-14 00:45:18', NULL),
(32, 'Módulo notificaciones', 'modulo_notificaciones', 'Notificaciones operativas y comerciales del sistema.', 'booleano', 'activo', '2026-04-07 01:34:34', '2026-04-14 00:45:18', NULL),
(33, 'Módulo historial', 'modulo_historial', 'Historial y auditoría de actividad operativa.', 'booleano', 'activo', '2026-04-07 01:34:34', '2026-04-14 00:45:18', NULL),
(34, 'Exportar clientes a Excel', 'clientes_exportar_excel', 'Permite exportar el listado de clientes a archivo Excel.', 'booleano', 'activo', '2026-04-07 01:34:34', NULL, NULL),
(35, 'Gestión de listas de precios por cliente', 'clientes_gestion_listas_precios', 'Permite asignar listas de precios por cliente.', 'booleano', 'activo', '2026-04-07 01:34:34', NULL, NULL),
(36, 'Asignación de vendedor por cliente', 'clientes_asignar_vendedor', 'Permite asociar vendedores responsables por cliente.', 'booleano', 'activo', '2026-04-07 01:34:34', NULL, NULL),
(37, 'Módulo checkout Flow', 'modulo_checkout_flow', 'Checkout de pagos Flow para compartir links de cobro.', 'booleano', 'activo', '2026-04-14 00:36:30', '2026-04-14 00:45:18', NULL),
(38, 'Módulo catálogo en línea', 'modulo_catalogo_en_linea', 'Landing pública de catálogo con filtros, carrito y checkout Flow.', 'booleano', 'activo', '2026-04-14 00:45:18', NULL, NULL),
(62, 'Compras por catálogo', 'modulo_compras_catalogo', 'Seguimiento de compras del catálogo con checkout Flow.', 'booleano', 'activo', '2026-04-15 14:54:59', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_actividad`
--

CREATE TABLE `historial_actividad` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `usuario_nombre` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modulo` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accion` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detalle` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_estados_cotizacion`
--

CREATE TABLE `historial_estados_cotizacion` (
  `id` bigint UNSIGNED NOT NULL,
  `cotizacion_id` bigint UNSIGNED NOT NULL,
  `estado` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `usuario_id` bigint UNSIGNED DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_estados_cotizacion`
--

INSERT INTO `historial_estados_cotizacion` (`id`, `cotizacion_id`, `estado`, `observaciones`, `usuario_id`, `fecha_creacion`) VALUES
(1, 1, 'enviada', 'Creación inicial', 70, '2026-04-09 01:09:50'),
(2, 2, 'rechazada', 'Creación inicial', 70, '2026-04-09 01:20:12'),
(3, 3, 'aprobada', 'Creación inicial', 70, '2026-04-09 01:22:21'),
(4, 4, 'enviada', 'Creación inicial', 70, '2026-04-09 01:28:45'),
(5, 5, 'aprobada', 'Creación inicial', 70, '2026-04-09 01:30:24'),
(6, 6, 'borrador', 'Creación inicial', 74, '2026-04-11 12:06:25'),
(7, 6, 'aprobada', 'Aprobación registrada desde módulo de aprobaciones', 74, '2026-04-11 12:13:57'),
(8, 6, 'aprobada', 'Aprobación registrada desde módulo de aprobaciones', 74, '2026-04-11 12:14:11'),
(9, 7, 'borrador', 'Creación inicial', 74, '2026-04-11 12:19:49'),
(10, 8, 'borrador', 'Creación inicial', 74, '2026-04-11 13:37:46'),
(11, 9, 'borrador', 'Creación inicial', 74, '2026-04-11 13:41:20'),
(12, 10, 'borrador', 'Creación inicial', 74, '2026-04-11 14:34:52'),
(13, 11, 'borrador', 'Creación inicial', 74, '2026-04-11 14:53:52'),
(17, 15, 'enviada', 'Creación inicial', 70, '2026-04-12 23:20:53'),
(18, 16, 'enviada', 'Creación inicial', 70, '2026-04-13 01:08:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_suscripciones`
--

CREATE TABLE `historial_suscripciones` (
  `id` bigint UNSIGNED NOT NULL,
  `suscripcion_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_suscripciones`
--

INSERT INTO `historial_suscripciones` (`id`, `suscripcion_id`, `accion`, `observaciones`, `fecha_creacion`) VALUES
(1, 54, 'actualizacion_estado', 'Cuenta suspendida temporalmente hasta validar pago Flow en /admin/flow/pagos. | Cambio de estado desde admin: activa', '2026-04-12 23:03:57'),
(2, 50, 'actualizacion_estado', 'Cuenta suspendida temporalmente hasta validar pago Flow en /admin/flow/pagos. | Cambio de estado desde admin: activa', '2026-04-12 23:04:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items_cotizacion`
--

CREATE TABLE `items_cotizacion` (
  `id` bigint UNSIGNED NOT NULL,
  `cotizacion_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED DEFAULT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` decimal(12,2) NOT NULL,
  `precio_unitario` decimal(12,2) NOT NULL,
  `descuento_tipo` enum('valor','porcentaje') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'valor',
  `descuento_valor` decimal(12,2) NOT NULL DEFAULT '0.00',
  `descuento_monto` decimal(12,2) NOT NULL DEFAULT '0.00',
  `porcentaje_impuesto` decimal(8,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `items_cotizacion`
--

INSERT INTO `items_cotizacion` (`id`, `cotizacion_id`, `producto_id`, `descripcion`, `cantidad`, `precio_unitario`, `descuento_tipo`, `descuento_valor`, `descuento_monto`, `porcentaje_impuesto`, `subtotal`, `total`, `fecha_creacion`) VALUES
(13, 2, 5, 'Unidad SSD portátil 1TB, conexión USB-C 3.2, resistente a golpes.', 4.00, 110000.00, 'valor', 0.00, 0.00, 19.00, 440000.00, 523600.00, '2026-04-09 01:20:12'),
(14, 2, 6, 'Limpieza física profunda, lubricación de ventiladores, cambio de pasta térmica de alto rendimiento y optimización lógica del sistema operativo para extender la vida útil del equipo.', 1.00, 35000.00, 'valor', 0.00, 0.00, 19.00, 35000.00, 41650.00, '2026-04-09 01:20:12'),
(22, 5, 3, 'Panel IPS 4K, 144Hz, bordes ultradelgados.', 2.00, 215000.00, 'valor', 0.00, 0.00, 19.00, 430000.00, 511700.00, '2026-04-09 01:32:03'),
(23, 5, 5, 'Unidad SSD portátil 1TB, conexión USB-C 3.2, resistente a golpes.', 5.00, 110000.00, 'valor', 0.00, 0.00, 19.00, 550000.00, 654500.00, '2026-04-09 01:32:03'),
(27, 1, 2, '8 núcleos, 16 hilos, Frecuencia 4.2GHz. Socket AM4/LGA.', 2.00, 285000.00, 'valor', 0.00, 0.00, 19.00, 570000.00, 678300.00, '2026-04-09 21:22:36'),
(28, 1, 1, 'CPU Quad-Core, 16GB RAM, SSD 512GB. Pantalla 14\" FHD.', 3.00, 870000.00, 'valor', 0.00, 0.00, 19.00, 2610000.00, 3105900.00, '2026-04-09 21:22:36'),
(29, 4, 1, 'CPU Quad-Core, 16GB RAM, SSD 512GB. Pantalla 14\" FHD.', 3.00, 870000.00, 'valor', 0.00, 0.00, 19.00, 2610000.00, 3105900.00, '2026-04-10 00:17:35'),
(30, 4, 7, 'Evaluación exhaustiva de vulnerabilidades en la red local, revisión de políticas de contraseñas y reporte de recomendaciones para la protección de datos sensibles de la empresa.', 1.00, 65000.00, 'valor', 0.00, 0.00, 19.00, 65000.00, 77350.00, '2026-04-10 00:17:35'),
(31, 4, 2, '8 núcleos, 16 hilos, Frecuencia 4.2GHz. Socket AM4/LGA.', 5.00, 285000.00, 'valor', 0.00, 0.00, 19.00, 1425000.00, 1695750.00, '2026-04-10 00:17:35'),
(32, 3, 3, 'Panel IPS 4K, 144Hz, bordes ultradelgados.', 4.00, 215000.00, 'valor', 0.00, 0.00, 19.00, 860000.00, 1023400.00, '2026-04-10 00:17:47'),
(33, 3, 4, 'Sistema Wi-Fi 6 malla, cobertura 250m2.', 1.00, 145000.00, 'valor', 0.00, 0.00, 19.00, 145000.00, 172550.00, '2026-04-10 00:17:47'),
(41, 6, 9, '7mm', 5.00, 6500.00, 'valor', 0.00, 0.00, 19.00, 32500.00, 38675.00, '2026-04-11 12:09:33'),
(42, 6, 8, '7mm', 30.00, 2500.00, 'valor', 0.00, 0.00, 19.00, 75000.00, 89250.00, '2026-04-11 12:09:33'),
(45, 7, 8, 'cargador telefono', 20.00, 2500.00, 'porcentaje', 10.00, 5000.00, 19.00, 45000.00, 53550.00, '2026-04-11 12:20:03'),
(46, 7, 9, 'cargador telefono', 20.00, 6500.00, 'porcentaje', 10.00, 13000.00, 19.00, 117000.00, 139230.00, '2026-04-11 12:20:03'),
(47, 8, 11, 'plumon cama 1 1/2', 1.00, 18000.00, 'valor', 0.00, 0.00, 19.00, 18000.00, 21420.00, '2026-04-11 13:37:46'),
(48, 8, 12, 'sabanas de 1 1/2', 1.00, 18000.00, 'valor', 0.00, 0.00, 19.00, 18000.00, 21420.00, '2026-04-11 13:37:46'),
(49, 9, 9, 'cargador telefono', 1.00, 6500.00, 'valor', 0.00, 0.00, 19.00, 6500.00, 7735.00, '2026-04-11 13:41:20'),
(50, 9, 8, '7mm', 23.00, 2500.00, 'valor', 0.00, 0.00, 19.00, 57500.00, 68425.00, '2026-04-11 13:41:20'),
(51, 10, 13, 'buzo de niño', 6.00, 15900.00, 'valor', 0.00, 0.00, 19.00, 95400.00, 113526.00, '2026-04-11 14:34:52'),
(52, 10, 11, 'plumon cama 1 1/2', 2.00, 18000.00, 'valor', 0.00, 0.00, 19.00, 36000.00, 42840.00, '2026-04-11 14:34:52'),
(53, 11, 13, 'buzo de niño', 6.00, 15900.00, 'valor', 0.00, 0.00, 19.00, 95400.00, 113526.00, '2026-04-11 14:53:52'),
(54, 11, 12, 'sabanas de 1 1/2', 1.00, 18000.00, 'valor', 0.00, 0.00, 19.00, 18000.00, 21420.00, '2026-04-11 14:53:52'),
(65, 15, 5, 'Unidad SSD portátil 1TB, conexión USB-C 3.2, resistente a golpes.', 1.00, 110000.00, 'porcentaje', 15.00, 16500.00, 19.00, 93500.00, 111265.00, '2026-04-12 23:20:53'),
(66, 15, 3, 'Panel IPS 4K, 144Hz, bordes ultradelgados.', 2.00, 215000.00, 'porcentaje', 15.00, 64500.00, 19.00, 365500.00, 434945.00, '2026-04-12 23:20:53'),
(67, 15, 2, '8 núcleos, 16 hilos, Frecuencia 4.2GHz. Socket AM4/LGA.', 31.00, 285000.00, 'porcentaje', 15.00, 1325250.00, 19.00, 7509750.00, 8936602.50, '2026-04-12 23:20:53'),
(68, 15, 1, 'CPU Quad-Core, 16GB RAM, SSD 512GB. Pantalla 14\" FHD.', 1.00, 870000.00, 'porcentaje', 15.00, 130500.00, 19.00, 739500.00, 880005.00, '2026-04-12 23:20:53'),
(69, 16, 3, 'CPU Quad-Core, 16GB RAM, SSD 512GB. Pantalla 14\" FHD.', 15.00, 215000.00, 'porcentaje', 10.00, 322500.00, 19.00, 2902500.00, 3453975.00, '2026-04-13 01:08:27'),
(70, 16, 2, '8 núcleos, 16 hilos, Frecuencia 4.2GHz. Socket AM4/LGA.', 50.00, 285000.00, 'porcentaje', 90.00, 12825000.00, 19.00, 1425000.00, 1695750.00, '2026-04-13 01:08:27'),
(71, 16, 5, 'CPU Quad-Core, 16GB RAM, SSD 512GB. Pantalla 14\" FHD.', 5.00, 121000.00, 'valor', 0.00, 0.00, 19.00, 605000.00, 719950.00, '2026-04-13 01:08:27');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items_venta_pos`
--

CREATE TABLE `items_venta_pos` (
  `id` bigint UNSIGNED NOT NULL,
  `venta_pos_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `codigo_producto` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre_producto` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cantidad` decimal(12,2) NOT NULL DEFAULT '0.00',
  `precio_unitario` decimal(12,2) NOT NULL DEFAULT '0.00',
  `descuento` decimal(12,2) NOT NULL DEFAULT '0.00',
  `impuesto` decimal(12,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `items_venta_pos`
--

INSERT INTO `items_venta_pos` (`id`, `venta_pos_id`, `producto_id`, `codigo_producto`, `nombre_producto`, `cantidad`, `precio_unitario`, `descuento`, `impuesto`, `subtotal`, `total`) VALUES
(1, 1, 1, 'LAP-ZEN-01', 'Laptop Zenit v14 Pro', 1.00, 870000.00, 0.00, 165300.00, 870000.00, 1035300.00),
(2, 1, 5, 'SSD-STE-1TB', 'Disco SSD Externo Terra-S Stellar', 1.00, 110000.00, 0.00, 20900.00, 110000.00, 130900.00),
(3, 2, 6, 'SRV-MANT-01', 'Plan de Mantenimiento Preventivo', 1.00, 35000.00, 0.00, 6650.00, 35000.00, 41650.00),
(4, 2, 2, 'CPU-VOLT-V8', 'Procesador Core-X V8', 1.00, 285000.00, 0.00, 54150.00, 285000.00, 339150.00),
(5, 2, 7, 'SRV-CONS-101', 'Auditoría de Ciberseguridad Inicial', 1.00, 65000.00, 0.00, 12350.00, 65000.00, 77350.00),
(6, 3, 7, 'SRV-CONS-101', 'Auditoría de Ciberseguridad Inicial', 1.00, 65000.00, 0.00, 12350.00, 65000.00, 77350.00),
(7, 4, 2, 'CPU-VOLT-V8', 'Procesador Core-X V8', 1.00, 285000.00, 0.00, 54150.00, 285000.00, 339150.00),
(8, 4, 6, 'SRV-MANT-01', 'Plan de Mantenimiento Preventivo', 1.00, 35000.00, 0.00, 6650.00, 35000.00, 41650.00),
(9, 5, 3, 'MON-OPT-27', 'Monitor Vision-View 27\"', 1.00, 215000.00, 5000.00, 39900.00, 215000.00, 249900.00),
(10, 5, 6, 'SRV-MANT-01', 'Plan de Mantenimiento Preventivo', 1.00, 35000.00, 5250.00, 5652.50, 35000.00, 35402.50),
(11, 6, 9, 'c123', 'cargador telefono', 1.00, 6500.00, 0.00, 1235.00, 6500.00, 7735.00),
(12, 6, 8, '01245', 'cuadernos universitarios', 1.00, 2500.00, 0.00, 475.00, 2500.00, 2975.00),
(13, 7, 11, '2321', 'plumon de cama 2 plazas', 3.00, 18000.00, 0.00, 10260.00, 54000.00, 64260.00),
(14, 7, 12, '023', 'sabanas 1 1/2', 2.00, 18000.00, 0.00, 6840.00, 36000.00, 42840.00),
(15, 8, 12, '023', 'sabanas 1 1/2', 1.00, 18000.00, 0.00, 3420.00, 18000.00, 21420.00),
(16, 8, 8, '01245', 'cuadernos universitarios', 1.00, 2500.00, 0.00, 475.00, 2500.00, 2975.00),
(17, 8, 9, 'c123', 'cargador telefono', 1.00, 6500.00, 0.00, 1235.00, 6500.00, 7735.00),
(18, 9, 12, '023', 'sabanas 1 1/2', 1.00, 18000.00, 0.00, 3420.00, 18000.00, 21420.00),
(19, 9, 11, '2321', 'plumon de cama 2 plazas', 1.00, 18000.00, 0.00, 3420.00, 18000.00, 21420.00),
(20, 10, 9, 'c123', 'cargador telefono', 1.00, 6500.00, 0.00, 1235.00, 6500.00, 7735.00),
(21, 10, 12, '023', 'sabanas 1 1/2', 1.00, 18000.00, 0.00, 3420.00, 18000.00, 21420.00),
(22, 11, 13, '124', 'ropa de niño', 1.01, 15900.00, 0.00, 3051.21, 16059.00, 19110.21),
(23, 11, 11, '2321', 'plumon de cama 2 plazas', 1.00, 18000.00, 0.00, 3420.00, 18000.00, 21420.00),
(24, 12, 13, '124', 'ropa de niño', 1.00, 15900.00, 0.00, 3021.00, 15900.00, 18921.00),
(25, 12, 11, '2321', 'plumon de cama 2 plazas', 1.00, 18000.00, 0.00, 3420.00, 18000.00, 21420.00),
(26, 12, 8, '01245', 'cuadernos universitarios', 1.00, 2500.00, 0.00, 475.00, 2500.00, 2975.00),
(35, 17, 4, 'NET-W6-MSH', 'Router Mesh Omni-Link W6', 1.00, 145000.00, 0.00, 27550.00, 145000.00, 172550.00),
(36, 17, 7, 'SRV-CONS-101', 'Auditoría de Ciberseguridad Inicial', 1.00, 65000.00, 0.00, 12350.00, 65000.00, 77350.00),
(37, 17, 5, 'SSD-STE-1TB', 'Disco SSD Externo Terra-S Stellar', 1.00, 110000.00, 0.00, 20900.00, 110000.00, 130900.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `listas_precios`
--

CREATE TABLE `listas_precios` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vigencia_desde` date DEFAULT NULL,
  `vigencia_hasta` date DEFAULT NULL,
  `tipo_lista` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `canal_venta` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `segmento_mercado` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ajuste_tipo` enum('incremento','descuento') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'incremento',
  `ajuste_porcentaje` decimal(8,4) NOT NULL DEFAULT '0.0000',
  `estado` enum('activo','inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `reglas_base` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `listas_precios`
--

INSERT INTO `listas_precios` (`id`, `empresa_id`, `nombre`, `vigencia_desde`, `vigencia_hasta`, `tipo_lista`, `canal_venta`, `segmento_mercado`, `ajuste_tipo`, `ajuste_porcentaje`, `estado`, `reglas_base`, `fecha_creacion`) VALUES
(1, 69, 'Lanzamiento E-commerce', '2026-04-08', '2026-12-31', 'Promocion', 'ecommerce', NULL, 'descuento', 10.0000, 'activo', 'ALCANCE: Categoría \"Periféricos\" y \"Almacenamiento\". AJUSTE: -10% sobre precio base.', '2026-04-08 15:36:14'),
(2, 69, 'Mayorista 2026', '2026-04-08', '2026-12-31', 'Mayorista', NULL, NULL, 'descuento', 15.0000, 'activo', 'ALCANCE: Todas las categorías. AJUSTE: -15% sobre el precio base. OBS: Aplicar solo a compras superiores a 10 unidades por SKU.', '2026-04-08 15:37:06'),
(3, 69, 'Lista de Precios General 2026', '2026-04-08', '2027-12-31', 'General', NULL, NULL, 'incremento', 0.0000, 'activo', 'ALCANCE: Catálogo completo. AJUSTE: 0% (Precio base de ficha). OBS: Esta es la lista maestra de la tienda para ventas al detalle y público general.', '2026-04-08 15:37:55'),
(4, 73, 'cliente mayorista', '2026-04-11', '2026-04-30', 'general', NULL, NULL, 'descuento', 10.0000, 'activo', NULL, '2026-04-11 10:48:04'),
(5, 73, 'cliente mayoriste prueba cuatro', '2026-04-11', '2026-04-29', 'general', NULL, NULL, 'incremento', 0.0000, 'activo', '', '2026-04-11 12:19:11'),
(6, 73, 'Mayorista Prueba cinco', '2026-04-11', '2026-04-30', 'general', NULL, NULL, 'incremento', 5.0000, 'activo', '', '2026-04-11 13:31:15'),
(7, 73, 'Mayorista Prueba cinco', NULL, NULL, 'general', NULL, NULL, 'descuento', 5.0000, 'activo', '', '2026-04-11 13:31:33'),
(8, 73, 'mayorista prueba seis', '2026-04-11', '2026-04-30', 'general', NULL, NULL, 'descuento', 5.0000, 'activo', '', '2026-04-11 13:43:18'),
(11, 69, 'Descuento escalonado', '2026-04-13', '2026-05-03', 'volumen', NULL, NULL, 'descuento', 0.0000, 'activo', '10:10%, 50:90%', '2026-04-12 23:46:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `listas_precios_reglas`
--

CREATE TABLE `listas_precios_reglas` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `lista_precio_id` bigint UNSIGNED NOT NULL,
  `ambito` enum('global','categoria','producto') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'global',
  `categoria_id` bigint UNSIGNED DEFAULT NULL,
  `producto_id` bigint UNSIGNED DEFAULT NULL,
  `tipo_ajuste` enum('incremento','descuento') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'incremento',
  `porcentaje` decimal(8,4) NOT NULL DEFAULT '0.0000',
  `cantidad_min` decimal(12,2) DEFAULT NULL,
  `cantidad_max` decimal(12,2) DEFAULT NULL,
  `prioridad` int NOT NULL DEFAULT '100',
  `estado` enum('activo','inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `observaciones` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_actividad`
--

CREATE TABLE `logs_actividad` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED DEFAULT NULL,
  `usuario_id` bigint UNSIGNED DEFAULT NULL,
  `modulo` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accion` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detalle` text COLLATE utf8mb4_unicode_ci,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_administracion`
--

CREATE TABLE `logs_administracion` (
  `id` bigint UNSIGNED NOT NULL,
  `admin_usuario_id` bigint UNSIGNED DEFAULT NULL,
  `empresa_id` bigint UNSIGNED DEFAULT NULL,
  `usuario_objetivo_id` bigint UNSIGNED DEFAULT NULL,
  `modulo` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accion` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detalle` text COLLATE utf8mb4_unicode_ci,
  `ip` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `logs_administracion`
--

INSERT INTO `logs_administracion` (`id`, `admin_usuario_id`, `empresa_id`, `usuario_objetivo_id`, `modulo`, `accion`, `detalle`, `ip`, `user_agent`, `fecha_creacion`) VALUES
(1, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 1', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 01:45:55'),
(2, 1, 2, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 14:02:59'),
(3, 1, 6, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 16:00:26'),
(4, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 1', '190.47.84.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 19:25:47'),
(5, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 2', '190.47.84.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 19:25:57'),
(6, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 3', '190.47.84.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 19:28:06'),
(7, 1, 12, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 19:39:20'),
(8, 1, 11, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 19:39:24'),
(9, 1, 10, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 19:39:29'),
(10, 1, 9, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 19:39:35'),
(11, 1, 8, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 19:39:41'),
(12, 1, 14, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 19:40:41'),
(13, 1, 16, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 19:41:49'),
(14, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 2', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 19:41:59'),
(15, 1, 19, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 20:04:18'),
(16, 1, 18, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 20:04:31'),
(17, 1, 20, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 20:27:47'),
(18, 1, 21, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 20:30:32'),
(19, 1, 24, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 22:16:39'),
(20, 1, 26, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 22:31:11'),
(21, 1, 27, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 22:34:33'),
(22, 1, 28, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 22:40:27'),
(23, 1, 22, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 22:40:34'),
(24, 1, 30, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 23:17:52'),
(25, 1, 31, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 23:24:13'),
(26, 1, 32, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 23:31:42'),
(27, 1, 33, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.47.84.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 23:49:25'),
(28, 1, 34, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-07 23:50:27'),
(29, 1, 35, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 00:02:12'),
(30, 1, 36, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 00:05:32'),
(31, 1, 38, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 00:15:54'),
(35, 1, 39, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 00:38:34'),
(36, 1, 40, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 00:44:27'),
(38, 1, 43, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 00:55:46'),
(39, 1, 44, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 01:00:52'),
(40, 1, 45, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 01:04:34'),
(41, 1, 46, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 01:08:35'),
(42, 1, 49, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 01:16:57'),
(43, 1, 48, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 01:17:12'),
(44, 1, 50, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 01:27:02'),
(45, 1, 52, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 01:31:42'),
(46, 1, 53, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 01:44:32'),
(47, 1, 54, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 01:48:03'),
(48, 1, 55, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 01:52:35'),
(50, 1, NULL, 57, 'admin_empresas', 'cambiar_estado', 'Estado a inactivo', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 02:00:06'),
(51, 1, 56, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 02:00:22'),
(52, 1, 57, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 02:05:17'),
(53, 1, 58, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 02:14:04'),
(54, 1, 65, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 02:32:34'),
(61, 1, 67, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 03:38:15'),
(62, 1, 66, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 03:38:20'),
(63, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 2', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 03:44:34'),
(64, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 3', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 03:44:43'),
(65, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 1', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 03:44:50'),
(66, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 03:54:39'),
(67, 1, NULL, 70, 'admin_empresas', 'actualizar_credenciales', 'Actualización de datos de acceso', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 03:56:48'),
(68, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 03:57:12'),
(69, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 1', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 04:10:57'),
(70, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 2', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 04:11:35'),
(71, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 3', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 04:12:11'),
(72, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 2', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 04:12:29'),
(73, 1, NULL, NULL, 'planes', 'editar', 'Actualización de plan ID 3', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 04:12:39'),
(75, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 12:57:13'),
(76, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 14:02:23'),
(77, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.47.84.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-08 14:34:18'),
(78, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.47.84.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-09 00:04:29'),
(79, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.47.84.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-09 22:39:25'),
(80, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.47.84.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-09 22:49:35'),
(81, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-10 00:17:25'),
(83, 1, 71, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 02:15:05'),
(85, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 02:31:15'),
(86, 1, 69, NULL, 'empresas', 'cambiar_estado', 'Cambio de estado a activa', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 12:34:11'),
(87, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 13:18:27'),
(88, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 13:48:50'),
(89, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 14:39:50'),
(90, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 14:45:50'),
(91, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 14:54:04'),
(92, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 15:20:52'),
(94, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 15:54:03'),
(95, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 17:38:15'),
(96, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 18:52:44'),
(97, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 20:53:03'),
(98, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 21:01:23'),
(102, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-11 22:47:17'),
(103, 1, 70, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 00:32:26'),
(104, 1, 68, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 00:32:36'),
(105, 1, 72, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 02:06:45'),
(106, 1, 75, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 02:35:36'),
(107, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 02:37:23'),
(108, 1, 73, NULL, 'empresas', 'cambiar_estado', 'Cambio de estado a vencida', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 02:43:17'),
(109, 1, 73, NULL, 'empresas', 'cambiar_plan', 'Plan asignado ID 1', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 02:59:48'),
(110, 1, 73, NULL, 'empresas', 'cambiar_estado', 'Cambio de estado a vencida', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 02:59:51'),
(113, 1, 74, NULL, 'empresas', 'eliminar', 'Eliminación completa de empresa y datos asociados', '190.47.84.173', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-12 03:49:16'),
(114, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.47.84.173', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-12 03:55:43'),
(115, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 20:37:22'),
(116, 1, 73, NULL, 'empresas', 'cambiar_estado', 'Cambio de estado a activa', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 21:39:07'),
(117, 1, 69, NULL, 'empresas', 'cambiar_estado', 'Cambio de estado a activa', '190.47.84.173', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-12 22:49:33'),
(118, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.47.84.173', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-12 22:49:56'),
(119, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 22:56:51'),
(120, 1, NULL, 70, 'admin_empresas', 'cambiar_estado', 'Estado a inactivo', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 22:57:03'),
(121, 1, NULL, 70, 'admin_empresas', 'cambiar_estado', 'Estado a activo', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 22:57:11'),
(122, 1, 73, NULL, 'empresas', 'cambiar_estado', 'Cambio de estado a activa', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 22:57:16'),
(123, 1, 73, NULL, 'empresas', 'cambiar_estado', 'Cambio de estado a activa', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 23:03:57'),
(124, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 23:04:02'),
(125, 1, NULL, 70, 'admin_empresas', 'cambiar_estado', 'Estado a activo', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 23:04:21'),
(126, 1, 69, NULL, 'empresas', 'cambiar_estado', 'Cambio de estado a activa', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 23:04:26'),
(127, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 23:04:31'),
(128, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-12 23:18:02'),
(129, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.47.84.173', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-12 23:32:18'),
(130, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.47.84.173', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-12 23:33:34'),
(131, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-13 00:38:58'),
(132, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-13 00:45:01'),
(133, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-14 00:47:20'),
(134, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-14 01:54:15'),
(135, 1, 77, NULL, 'suscripciones', 'extender_vigencia', 'Extensión de 335 días', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-14 16:36:31'),
(136, 1, 77, 78, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-14 16:37:11'),
(137, 1, 77, 78, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-14 16:49:25'),
(138, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-14 20:14:46'),
(139, 1, 77, 78, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-14 20:24:27'),
(140, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-14 21:30:07'),
(141, 1, 77, 78, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-14 21:38:40'),
(142, 1, 69, 70, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-14 22:27:23'),
(143, 1, 77, 78, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-14 22:45:14'),
(144, 1, 73, 74, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.47.84.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-15 12:39:36'),
(145, 1, 77, 78, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.47.84.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-15 12:39:47'),
(146, 1, 77, 78, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-15 13:31:44'),
(147, 1, 77, 78, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.47.84.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-16 16:21:17'),
(148, 1, 77, NULL, 'suscripciones', 'extender_vigencia', 'Extensión de 9737 días', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-16 17:59:29'),
(149, 1, 77, 78, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-17 06:39:05'),
(150, 1, 77, 78, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.13.179.172', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', '2026-04-17 18:59:27'),
(151, 1, 77, 78, 'admin_empresas', 'acceso_panel_empresa', 'Acceso de soporte al panel de empresa sin cambiar sesión de superadministrador.', '190.47.84.173', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-19 15:48:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_correos`
--

CREATE TABLE `logs_correos` (
  `id` bigint UNSIGNED NOT NULL,
  `destinatario` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `asunto` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plantilla` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `estado` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Volcado de datos para la tabla `logs_correos`
--

INSERT INTO `logs_correos` (`id`, `destinatario`, `asunto`, `plantilla`, `payload`, `estado`, `fecha_creacion`) VALUES
(1, 'wbyqsvtsvsregqjndq@nespj.com', 'Pago confirmado en Flow - Vextra', 'flow_pago_confirmado', '{\"html\":\"<div style=\\\"font-family:Arial,sans-serif;color:#1f2937;line-height:1.5\\\"><h2 style=\\\"margin:0 0 12px 0;color:#0f172a;\\\">¡Tu pago fue confirmado!<\\/h2><p>Hola sole,<\\/p><p>Flow confirmó tu pago y tu suscripción ya se encuentra activa en Vextra.<\\/p><div style=\\\"border:1px solid #e5e7eb;border-radius:8px;padding:12px 14px;margin:14px 0;background:#f8fafc;\\\"><p style=\\\"margin:0 0 6px 0;\\\"><strong>Plan:<\\/strong> Básico Pyme<\\/p><p style=\\\"margin:0;\\\"><strong>Monto:<\\/strong> $500 CLP<\\/p><\\/div><p style=\\\"margin:0 0 14px 0;\\\">Puedes ingresar aquí: <a href=\\\"\\/iniciar-sesion\\\">\\/iniciar-sesion<\\/a><\\/p><p style=\\\"font-size:12px;color:#6b7280;margin:0;\\\">Este correo fue enviado automáticamente por Vextra.<\\/p><\\/div>\",\"smtp_global\":{\"host\":\"mail.vextra.cl\",\"puerto\":\"465\",\"usuario\":\"noresponder@vextra.cl\",\"password\":\"Tb*Kz{ny{[_E!%,Q\",\"encryption\":\"ssl\",\"remitente_correo\":\"noresponder@vextra.cl\",\"remitente_nombre\":\"Vextra Notificaciones\"}}', 'enviado', '2026-04-08 01:28:46'),
(2, 'odujelwtlcuxkvxbob@nespj.com', 'Pago confirmado en Flow - Vextra', 'flow_pago_confirmado', '{\"html\":\"<div style=\\\"font-family:Arial,sans-serif;color:#1f2937;line-height:1.5\\\"><h2 style=\\\"margin:0 0 12px 0;color:#0f172a;\\\">¡Tu pago fue confirmado!<\\/h2><p>Hola sole,<\\/p><p>Flow confirmó tu pago y tu suscripción ya se encuentra activa en Vextra.<\\/p><div style=\\\"border:1px solid #e5e7eb;border-radius:8px;padding:12px 14px;margin:14px 0;background:#f8fafc;\\\"><p style=\\\"margin:0 0 6px 0;\\\"><strong>Plan:<\\/strong> Básico Pyme<\\/p><p style=\\\"margin:0;\\\"><strong>Monto:<\\/strong> $500 CLP<\\/p><\\/div><p style=\\\"margin:0 0 14px 0;\\\">Puedes ingresar aquí: <a href=\\\"\\/iniciar-sesion\\\">\\/iniciar-sesion<\\/a><\\/p><p style=\\\"font-size:12px;color:#6b7280;margin:0;\\\">Este correo fue enviado automáticamente por Vextra.<\\/p><\\/div>\",\"smtp_empresa\":{\"host\":\"\",\"puerto\":\"\",\"usuario\":\"\",\"encryption\":\"\",\"remitente_correo\":\"odujelwtlcuxkvxbob@nespj.com\",\"remitente_nombre\":\"sole\"},\"empresa_id\":53}', 'enviado', '2026-04-08 01:35:47'),
(3, 'pablitoislamella@gmail.com', 'Pago confirmado en Flow - Vextra', 'flow_pago_confirmado', '{\"html\":\"<div style=\\\"font-family:Arial,sans-serif;background:#f6f7fb;padding:24px 0;\\\"><table role=\\\"presentation\\\" style=\\\"width:100%;max-width:640px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;\\\"><tr><td style=\\\"background:#4632a8;color:#ffffff;padding:18px 24px;border-radius:12px 12px 0 0;\\\"><h2 style=\\\"margin:0;font-size:22px;\\\">Pago confirmado en Vextra<\\/h2><\\/td><\\/tr><tr><td style=\\\"padding:20px 24px;color:#1f2937;\\\"><p style=\\\"margin:0 0 12px;\\\">Hola sole,<\\/p><p style=\\\"margin:0 0 16px;\\\">Tu pago fue aprobado y tu cuenta ya está activa.<\\/p><table style=\\\"width:100%;border-collapse:collapse;font-size:14px;\\\"><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Usuario<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">pablitoislamella@gmail.com<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Contraseña<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">La que registraste al crear tu cuenta<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Plan<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">Básico Pyme<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Monto<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">$500 CLP<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Duración<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">1 mes<\\/td><\\/tr><tr><td style=\\\"padding:8px;\\\"><strong>Inicio de sesión<\\/strong><\\/td><td style=\\\"padding:8px;\\\"><a href=\\\"\\/iniciar-sesion\\\">\\/iniciar-sesion<\\/a><\\/td><\\/tr><\\/table><p style=\\\"margin:16px 0 0;font-size:12px;color:#6b7280;\\\">Correo enviado automáticamente desde noresponder@vextra.cl.<\\/p><\\/div>\",\"smtp_global\":{\"host\":\"mail.vextra.cl\",\"puerto\":\"465\",\"usuario\":\"noresponder@vextra.cl\",\"password\":\"Tb*Kz{ny{[_E!%,Q\",\"encryption\":\"ssl\",\"remitente_correo\":\"noresponder@vextra.cl\",\"remitente_nombre\":\"Vextra Notificaciones\"}}', 'enviado', '2026-04-08 02:02:19'),
(4, 'soledadmellazuniga@gmail.com', 'Pago confirmado en Flow - Vextra', 'flow_pago_confirmado', '{\"html\":\"<div style=\\\"font-family:Arial,sans-serif;background:#f6f7fb;padding:24px 0;\\\"><table role=\\\"presentation\\\" style=\\\"width:100%;max-width:640px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;\\\"><tr><td style=\\\"background:#4632a8;color:#ffffff;padding:18px 24px;border-radius:12px 12px 0 0;\\\"><h2 style=\\\"margin:0;font-size:22px;\\\">Pago confirmado en Vextra<\\/h2><\\/td><\\/tr><tr><td style=\\\"padding:20px 24px;color:#1f2937;\\\"><p style=\\\"margin:0 0 12px;\\\">Hola sole,<\\/p><p style=\\\"margin:0 0 16px;\\\">Tu pago fue aprobado y tu cuenta ya está activa.<\\/p><table style=\\\"width:100%;border-collapse:collapse;font-size:14px;\\\"><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Usuario<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">soledadmellazuniga@gmail.com<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Contraseña<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">La que registraste al crear tu cuenta<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Plan<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">Básico Pyme<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Monto<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">$500 CLP<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Duración<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">1 mes<\\/td><\\/tr><tr><td style=\\\"padding:8px;\\\"><strong>Inicio de sesión<\\/strong><\\/td><td style=\\\"padding:8px;\\\"><a href=\\\"\\/iniciar-sesion\\\">\\/iniciar-sesion<\\/a><\\/td><\\/tr><\\/table><p style=\\\"margin:16px 0 0;font-size:12px;color:#6b7280;\\\">Correo enviado automáticamente desde noresponder@vextra.cl.<\\/p><\\/div>\",\"smtp_global\":{\"host\":\"mail.vextra.cl\",\"puerto\":\"465\",\"usuario\":\"noresponder@vextra.cl\",\"password\":\"Tb*Kz{ny{[_E!%,Q\",\"encryption\":\"ssl\",\"remitente_correo\":\"noresponder@vextra.cl\",\"remitente_nombre\":\"Vextra Notificaciones\"}}', 'enviado', '2026-04-08 02:38:26'),
(5, 'erwin.2785@gmail.com', 'Pago confirmado en Flow - Vextra', 'flow_pago_confirmado', '{\"html\":\"<div style=\\\"font-family:Arial,sans-serif;background:#f6f7fb;padding:24px 0;\\\"><table role=\\\"presentation\\\" style=\\\"width:100%;max-width:640px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;\\\"><tr><td style=\\\"background:#4632a8;color:#ffffff;padding:18px 24px;border-radius:12px 12px 0 0;\\\"><h2 style=\\\"margin:0;font-size:22px;\\\">Pago confirmado en Vextra<\\/h2><\\/td><\\/tr><tr><td style=\\\"padding:20px 24px;color:#1f2937;\\\"><p style=\\\"margin:0 0 12px;\\\">Hola Erwin Isla,<\\/p><p style=\\\"margin:0 0 16px;\\\">Tu pago fue aprobado y tu cuenta ya está activa.<\\/p><table style=\\\"width:100%;border-collapse:collapse;font-size:14px;\\\"><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Usuario<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">erwin.2785@gmail.com<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Contraseña<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">La que registraste al crear tu cuenta<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Plan<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">Básico Pyme<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Monto<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">$500 CLP<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Duración<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">1 mes<\\/td><\\/tr><tr><td style=\\\"padding:8px;\\\"><strong>Inicio de sesión<\\/strong><\\/td><td style=\\\"padding:8px;\\\"><a href=\\\"\\/iniciar-sesion\\\">\\/iniciar-sesion<\\/a><\\/td><\\/tr><\\/table><p style=\\\"margin:16px 0 0;font-size:12px;color:#6b7280;\\\">Correo enviado automáticamente desde noresponder@vextra.cl.<\\/p><\\/div>\",\"smtp_global\":{\"host\":\"mail.vextra.cl\",\"puerto\":\"465\",\"usuario\":\"noresponder@vextra.cl\",\"password\":\"Tb*Kz{ny{[_E!%,Q\",\"encryption\":\"ssl\",\"remitente_correo\":\"noresponder@vextra.cl\",\"remitente_nombre\":\"Vextra Notificaciones\"}}', 'enviado', '2026-04-08 03:40:33'),
(6, 'javigonzalez2024@udec.cl', 'Pago confirmado en Flow - Vextra', 'flow_pago_confirmado', '{\"html\":\"<div style=\\\"font-family:Arial,sans-serif;background:#f6f7fb;padding:24px 0;\\\"><table role=\\\"presentation\\\" style=\\\"width:100%;max-width:640px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;\\\"><tr><td style=\\\"background:#4632a8;color:#ffffff;padding:18px 24px;border-radius:12px 12px 0 0;\\\"><h2 style=\\\"margin:0;font-size:22px;\\\">Pago confirmado en Vextra<\\/h2><\\/td><\\/tr><tr><td style=\\\"padding:20px 24px;color:#1f2937;\\\"><p style=\\\"margin:0 0 12px;\\\">Hola michi tiburon rosado,<\\/p><p style=\\\"margin:0 0 16px;\\\">Tu pago fue aprobado y tu cuenta ya está activa.<\\/p><table style=\\\"width:100%;border-collapse:collapse;font-size:14px;\\\"><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Usuario<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">javigonzalez2024@udec.cl<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Contraseña<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">La que registraste al crear tu cuenta<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Plan<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">Profesional Emprende<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Monto<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">$500 CLP<\\/td><\\/tr><tr><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\"><strong>Duración<\\/strong><\\/td><td style=\\\"padding:8px;border-bottom:1px solid #e5e7eb;\\\">1 mes<\\/td><\\/tr><tr><td style=\\\"padding:8px;\\\"><strong>Inicio de sesión<\\/strong><\\/td><td style=\\\"padding:8px;\\\"><a href=\\\"\\/iniciar-sesion\\\">\\/iniciar-sesion<\\/a><\\/td><\\/tr><\\/table><p style=\\\"margin:16px 0 0;font-size:12px;color:#6b7280;\\\">Correo enviado automáticamente desde noresponder@vextra.cl.<\\/p><\\/div>\",\"smtp_global\":{\"host\":\"mail.vextra.cl\",\"puerto\":\"465\",\"usuario\":\"noresponder@vextra.cl\",\"password\":\"Tb*Kz{ny{[_E!%,Q\",\"encryption\":\"ssl\",\"remitente_correo\":\"noresponder@vextra.cl\",\"remitente_nombre\":\"Vextra Notificaciones\"}}', 'enviado', '2026-04-08 03:53:46'),
(7, 'contacto@vextra.cl', 'Nuevo lead desde landing', 'landing_contacto', '{\"nombre\":\"Municipalidad\",\"correo\":\"erwin.2785@gmail.com\",\"mensaje\":\"Preuba\"}', 'enviado', '2026-04-08 04:27:06'),
(8, 'contacto@vextra.cl', 'Nuevo lead desde landing', 'landing_contacto', '{\"nombre\":\"Municipalidad\",\"correo\":\"erwin.2785@gmail.com\",\"telefono\":\"+56944627287\",\"empresa\":\"Prueba\",\"tipo_contacto\":\"prospecto\",\"motivo_consulta\":\"planes\",\"mensaje\":\"Prueba\",\"html\":\"<h2>Nuevo lead desde landing<\\/h2><p><strong>Nombre:<\\/strong> Municipalidad<\\/p><p><strong>Correo:<\\/strong> erwin.2785@gmail.com<\\/p><p><strong>Teléfono:<\\/strong> +56944627287<\\/p><p><strong>Empresa:<\\/strong> Prueba<\\/p><p><strong>Tipo de contacto:<\\/strong> Posible cliente<\\/p><p><strong>Motivo de consulta:<\\/strong> planes<\\/p><p><strong>Mensaje:<\\/strong><br>Prueba<\\/p>\"}', 'enviado', '2026-04-08 04:34:53'),
(9, 'javigonzalez2024@udec.cl', 'Orden de compra OC-069-000001', 'orden_compra_proveedor', '{\"empresa\":\"Empresa estudio SPA\",\"proveedor\":\"Importadora Tecnológica del Sur SpA\",\"numero\":\"OC-069-000001\",\"mensaje_html\":\"<p>Estimado proveedor,<\\/p><p>Adjuntamos la orden de compra <strong>OC-069-000001<\\/strong>.<\\/p><p>Puedes descargarla desde este enlace: <a href=\\\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\">http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\"}', 'enviado', '2026-04-08 14:46:36'),
(10, 'javieraagonzalezmoeller@gmail.com', 'Orden de compra OC-069-000001', 'orden_compra_proveedor', '{\"empresa\":\"Empresa estudio SPA\",\"proveedor\":\"Importadora Tecnológica del Sur SpA\",\"numero\":\"OC-069-000001\",\"mensaje_html\":\"<p>Estimado proveedor,<\\/p><p>Adjuntamos la orden de compra <strong>OC-069-000001<\\/strong>.<\\/p><p>Puedes descargarla desde este enlace: <a href=\\\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\">http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\"}', 'enviado', '2026-04-08 14:47:10'),
(11, 'javieraagonzalezmoeller@gmail.com', 'Orden de compra OC-069-000001', 'orden_compra_proveedor', '{\"empresa\":\"Empresa estudio SPA\",\"proveedor\":\"Importadora Tecnológica del Sur SpA\",\"numero\":\"OC-069-000001\",\"mensaje_html\":\"<p>Estimado proveedor,<\\/p><p>Compartimos la orden de compra <strong>OC-069-000001<\\/strong>.<\\/p><p>Vista pública: <a href=\\\"http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\">http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df<\\/a><\\/p><p>Descargar PDF: <a href=\\\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\">http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\",\"link_publico\":\"http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\"}', 'enviado', '2026-04-08 15:06:30'),
(12, 'logistica@laredes.cl', 'Orden de compra OC-069-000003', 'orden_compra_proveedor', '{\"empresa\":\"Empresa estudio SPA\",\"proveedor\":\"Soluciones de Conectividad Los Ángeles E.I.R.L.\",\"numero\":\"OC-069-000003\",\"mensaje_html\":\"<p>Estimado proveedor,<\\/p><p>Compartimos la orden de compra <strong>OC-069-000003<\\/strong>.<\\/p><p>Vista pública: <a href=\\\"http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/7a65cba647879688c7542d43cb1d9d64480b144a7907f8ac0b90e2403a238b16\\\">http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/7a65cba647879688c7542d43cb1d9d64480b144a7907f8ac0b90e2403a238b16<\\/a><\\/p><p>Descargar PDF: <a href=\\\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/3\\\">http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/3<\\/a><\\/p>\",\"link_publico\":\"http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/7a65cba647879688c7542d43cb1d9d64480b144a7907f8ac0b90e2403a238b16\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/3\"}', 'enviado', '2026-04-08 15:06:42'),
(13, 'contacto@globalclick.cl', 'Orden de compra OC-069-000002', 'orden_compra_proveedor', '{\"empresa\":\"Empresa estudio SPA\",\"proveedor\":\"Distribuidora de Accesorios Globales Ltda\",\"numero\":\"OC-069-000002\",\"html\":\"<p>Estimado proveedor,<\\/p><p>Compartimos la orden de compra <strong>OC-069-000002<\\/strong>.<\\/p><p>Vista pública: <a href=\\\"http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/1292c14c0e21bf93fa053873a0a9770ca350bbb9430b87b10e30be9e2d9ec7bd\\\">http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/1292c14c0e21bf93fa053873a0a9770ca350bbb9430b87b10e30be9e2d9ec7bd<\\/a><\\/p><p>Descargar PDF: <a href=\\\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/2\\\">http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/2<\\/a><\\/p>\",\"mensaje_html\":\"<p>Estimado proveedor,<\\/p><p>Compartimos la orden de compra <strong>OC-069-000002<\\/strong>.<\\/p><p>Vista pública: <a href=\\\"http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/1292c14c0e21bf93fa053873a0a9770ca350bbb9430b87b10e30be9e2d9ec7bd\\\">http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/1292c14c0e21bf93fa053873a0a9770ca350bbb9430b87b10e30be9e2d9ec7bd<\\/a><\\/p><p>Descargar PDF: <a href=\\\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/2\\\">http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/2<\\/a><\\/p>\",\"link_publico\":\"http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/1292c14c0e21bf93fa053873a0a9770ca350bbb9430b87b10e30be9e2d9ec7bd\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/2\"}', 'enviado', '2026-04-08 15:12:57'),
(14, 'javieraagonzalezmoeller@gmail.com', 'Orden de compra OC-069-000001', 'orden_compra_proveedor', '{\"empresa\":\"Empresa estudio SPA\",\"proveedor\":\"Importadora Tecnológica del Sur SpA\",\"numero\":\"OC-069-000001\",\"html\":\"<p>Estimado proveedor,<\\/p><p>Compartimos la orden de compra <strong>OC-069-000001<\\/strong>.<\\/p><p>Vista pública: <a href=\\\"http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\">http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df<\\/a><\\/p><p>Descargar PDF: <a href=\\\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\">http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\",\"mensaje_html\":\"<p>Estimado proveedor,<\\/p><p>Compartimos la orden de compra <strong>OC-069-000001<\\/strong>.<\\/p><p>Vista pública: <a href=\\\"http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\">http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df<\\/a><\\/p><p>Descargar PDF: <a href=\\\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\">http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\",\"link_publico\":\"http:\\/\\/localhost:8000\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\"}', 'enviado', '2026-04-08 15:30:05'),
(15, 'javieraagonzalezmoeller@gmail.com', 'Orden de compra OC-069-000001', 'orden_compra_proveedor', '{\"empresa\":\"Empresa estudio SPA\",\"proveedor\":\"Importadora Tecnológica del Sur SpA\",\"numero\":\"OC-069-000001\",\"html\":\"<p>Estimado proveedor,<\\/p><p>Compartimos la orden de compra <strong>OC-069-000001<\\/strong>.<\\/p><p>Vista pública: <a href=\\\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\">https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df<\\/a><\\/p><p>Descargar PDF: <a href=\\\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\">https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\",\"mensaje_html\":\"<p>Estimado proveedor,<\\/p><p>Compartimos la orden de compra <strong>OC-069-000001<\\/strong>.<\\/p><p>Vista pública: <a href=\\\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\">https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df<\\/a><\\/p><p>Descargar PDF: <a href=\\\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\">https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\",\"link_publico\":\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\"}', 'enviado', '2026-04-08 15:41:54'),
(16, 'javieraagonzalezmoeller@gmail.com', 'Orden de compra OC-069-000001', 'orden_compra_proveedor', '{\"empresa\":\"Empresa estudio SPA\",\"proveedor\":\"Importadora Tecnológica del Sur SpA\",\"numero\":\"OC-069-000001\",\"html\":\"<p>Estimado proveedor,<\\/p><p>Compartimos la orden de compra <strong>OC-069-000001<\\/strong>.<\\/p><p>Vista pública: <a href=\\\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\">https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df<\\/a><\\/p><p>Descargar PDF: <a href=\\\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\">https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\",\"mensaje_html\":\"<p>Estimado proveedor,<\\/p><p>Compartimos la orden de compra <strong>OC-069-000001<\\/strong>.<\\/p><p>Vista pública: <a href=\\\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\">https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df<\\/a><\\/p><p>Descargar PDF: <a href=\\\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\">https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\",\"link_publico\":\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\"}', 'enviado', '2026-04-08 15:49:14'),
(17, 'javieraagonzalezmoeller@gmail.com', 'Orden de compra OC-069-000001', 'orden_compra_proveedor', '{\"empresa\":\"Empresa estudio SPA\",\"proveedor\":\"Importadora Tecnológica del Sur SpA\",\"numero\":\"OC-069-000001\",\"html\":\"<p>Estimado proveedor,<\\/p><p>Compartimos la orden de compra <strong>OC-069-000001<\\/strong>.<\\/p><p>Vista pública: <a href=\\\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\">https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df<\\/a><\\/p><p>Descargar PDF: <a href=\\\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\">https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\",\"mensaje_html\":\"<p>Estimado proveedor,<\\/p><p>Compartimos la orden de compra <strong>OC-069-000001<\\/strong>.<\\/p><p>Vista pública: <a href=\\\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\">https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df<\\/a><\\/p><p>Descargar PDF: <a href=\\\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\">https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\",\"link_publico\":\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\"}', 'enviado', '2026-04-08 15:49:30'),
(18, 'javieraagonzalezmoeller@gmail.com', 'Orden de compra OC-069-000001', 'orden_compra_proveedor', '{\"empresa\":\"Empresa estudio SPA\",\"proveedor\":\"Importadora Tecnológica del Sur SpA\",\"numero\":\"OC-069-000001\",\"html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de orden de compra<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Importadora Tecnológica del Sur SpA<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la orden de compra <strong>OC-069-000001<\\/strong> con fecha de emisión <strong>2026-04-08<\\/strong> y entrega estimada <strong>2026-04-15<\\/strong>.<\\/p>\\n      <div style=\\\"border:1px solid #e5e7eb;border-radius:10px;background:#f9fafb;padding:14px;margin:0 0 16px;\\\">\\n        <table style=\\\"width:100%;border-collapse:collapse;font-size:13px;\\\">\\n          <tr><td style=\\\"padding:4px 0;color:#6b7280;\\\">Orden<\\/td><td style=\\\"padding:4px 0;text-align:right;\\\"><strong>OC-069-000001<\\/strong><\\/td><\\/tr>\\n          <tr><td style=\\\"padding:4px 0;color:#6b7280;\\\">Estado<\\/td><td style=\\\"padding:4px 0;text-align:right;\\\">emitida<\\/td><\\/tr>\\n          <tr><td style=\\\"padding:4px 0;color:#6b7280;\\\">Total<\\/td><td style=\\\"padding:4px 0;text-align:right;\\\">$0,00<\\/td><\\/tr>\\n        <\\/table>\\n      <\\/div>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisar la orden en línea desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver orden de compra<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">Descargar PDF de la orden:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue enviado a javieraagonzalezmoeller@gmail.com por  ().<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de orden de compra<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Importadora Tecnológica del Sur SpA<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la orden de compra <strong>OC-069-000001<\\/strong> con fecha de emisión <strong>2026-04-08<\\/strong> y entrega estimada <strong>2026-04-15<\\/strong>.<\\/p>\\n      <div style=\\\"border:1px solid #e5e7eb;border-radius:10px;background:#f9fafb;padding:14px;margin:0 0 16px;\\\">\\n        <table style=\\\"width:100%;border-collapse:collapse;font-size:13px;\\\">\\n          <tr><td style=\\\"padding:4px 0;color:#6b7280;\\\">Orden<\\/td><td style=\\\"padding:4px 0;text-align:right;\\\"><strong>OC-069-000001<\\/strong><\\/td><\\/tr>\\n          <tr><td style=\\\"padding:4px 0;color:#6b7280;\\\">Estado<\\/td><td style=\\\"padding:4px 0;text-align:right;\\\">emitida<\\/td><\\/tr>\\n          <tr><td style=\\\"padding:4px 0;color:#6b7280;\\\">Total<\\/td><td style=\\\"padding:4px 0;text-align:right;\\\">$0,00<\\/td><\\/tr>\\n        <\\/table>\\n      <\\/div>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisar la orden en línea desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver orden de compra<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">Descargar PDF de la orden:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue enviado a javieraagonzalezmoeller@gmail.com por  ().<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"link_publico\":\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\"}', 'enviado', '2026-04-08 15:58:53'),
(19, 'javieraagonzalezmoeller@gmail.com', 'Orden de compra OC-069-000001', 'orden_compra_proveedor', '{\"empresa\":\"Empresa estudio SPA\",\"proveedor\":\"Importadora Tecnológica del Sur SpA\",\"numero\":\"OC-069-000001\",\"html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de orden de compra<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Importadora Tecnológica del Sur SpA<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la orden de compra <strong>OC-069-000001<\\/strong> con fecha de emisión <strong>2026-04-08<\\/strong> y entrega estimada <strong>2026-04-15<\\/strong>.<\\/p>\\n      <div style=\\\"border:1px solid #e5e7eb;border-radius:10px;background:#f9fafb;padding:14px;margin:0 0 16px;\\\">\\n        <table style=\\\"width:100%;border-collapse:collapse;font-size:13px;\\\">\\n          <tr><td style=\\\"padding:4px 0;color:#6b7280;\\\">Orden<\\/td><td style=\\\"padding:4px 0;text-align:right;\\\"><strong>OC-069-000001<\\/strong><\\/td><\\/tr>\\n          <tr><td style=\\\"padding:4px 0;color:#6b7280;\\\">Estado<\\/td><td style=\\\"padding:4px 0;text-align:right;\\\">emitida<\\/td><\\/tr>\\n          <tr><td style=\\\"padding:4px 0;color:#6b7280;\\\">Total<\\/td><td style=\\\"padding:4px 0;text-align:right;\\\">$0,00<\\/td><\\/tr>\\n        <\\/table>\\n      <\\/div>\\n      <div style=\\\"margin:0 0 16px;\\\">\\n        <div style=\\\"font-size:13px;margin-bottom:8px;color:#111827;\\\"><strong>Detalle de productos<\\/strong><\\/div>\\n        <table style=\\\"width:100%;border-collapse:collapse;font-size:12px;background:#ffffff;\\\"><thead><tr><th style=\\\"padding:8px;border:1px solid #e5e7eb;background:#f9fafb;text-align:left;\\\">Código<\\/th><th style=\\\"padding:8px;border:1px solid #e5e7eb;background:#f9fafb;text-align:left;\\\">Descripción<\\/th><th style=\\\"padding:8px;border:1px solid #e5e7eb;background:#f9fafb;text-align:right;\\\">Cant.<\\/th><th style=\\\"padding:8px;border:1px solid #e5e7eb;background:#f9fafb;text-align:right;\\\">Costo<\\/th><th style=\\\"padding:8px;border:1px solid #e5e7eb;background:#f9fafb;text-align:right;\\\">Subtotal<\\/th><\\/tr><\\/thead><tbody><tr><td style=\\\"padding:8px;border:1px solid #e5e7eb;\\\">CPU-VOLT-V8<\\/td><td style=\\\"padding:8px;border:1px solid #e5e7eb;\\\">Procesador Core-X V8<\\/td><td style=\\\"padding:8px;border:1px solid #e5e7eb;text-align:right;\\\">10,00<\\/td><td style=\\\"padding:8px;border:1px solid #e5e7eb;text-align:right;\\\">$195.000,00<\\/td><td style=\\\"padding:8px;border:1px solid #e5e7eb;text-align:right;\\\">$1.950.000,00<\\/td><\\/tr><\\/tbody><\\/table>\\n      <\\/div>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisar la orden en línea desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver orden de compra<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">Descargar PDF de la orden:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue enviado a javieraagonzalezmoeller@gmail.com por  ().<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de orden de compra<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Importadora Tecnológica del Sur SpA<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la orden de compra <strong>OC-069-000001<\\/strong> con fecha de emisión <strong>2026-04-08<\\/strong> y entrega estimada <strong>2026-04-15<\\/strong>.<\\/p>\\n      <div style=\\\"border:1px solid #e5e7eb;border-radius:10px;background:#f9fafb;padding:14px;margin:0 0 16px;\\\">\\n        <table style=\\\"width:100%;border-collapse:collapse;font-size:13px;\\\">\\n          <tr><td style=\\\"padding:4px 0;color:#6b7280;\\\">Orden<\\/td><td style=\\\"padding:4px 0;text-align:right;\\\"><strong>OC-069-000001<\\/strong><\\/td><\\/tr>\\n          <tr><td style=\\\"padding:4px 0;color:#6b7280;\\\">Estado<\\/td><td style=\\\"padding:4px 0;text-align:right;\\\">emitida<\\/td><\\/tr>\\n          <tr><td style=\\\"padding:4px 0;color:#6b7280;\\\">Total<\\/td><td style=\\\"padding:4px 0;text-align:right;\\\">$0,00<\\/td><\\/tr>\\n        <\\/table>\\n      <\\/div>\\n      <div style=\\\"margin:0 0 16px;\\\">\\n        <div style=\\\"font-size:13px;margin-bottom:8px;color:#111827;\\\"><strong>Detalle de productos<\\/strong><\\/div>\\n        <table style=\\\"width:100%;border-collapse:collapse;font-size:12px;background:#ffffff;\\\"><thead><tr><th style=\\\"padding:8px;border:1px solid #e5e7eb;background:#f9fafb;text-align:left;\\\">Código<\\/th><th style=\\\"padding:8px;border:1px solid #e5e7eb;background:#f9fafb;text-align:left;\\\">Descripción<\\/th><th style=\\\"padding:8px;border:1px solid #e5e7eb;background:#f9fafb;text-align:right;\\\">Cant.<\\/th><th style=\\\"padding:8px;border:1px solid #e5e7eb;background:#f9fafb;text-align:right;\\\">Costo<\\/th><th style=\\\"padding:8px;border:1px solid #e5e7eb;background:#f9fafb;text-align:right;\\\">Subtotal<\\/th><\\/tr><\\/thead><tbody><tr><td style=\\\"padding:8px;border:1px solid #e5e7eb;\\\">CPU-VOLT-V8<\\/td><td style=\\\"padding:8px;border:1px solid #e5e7eb;\\\">Procesador Core-X V8<\\/td><td style=\\\"padding:8px;border:1px solid #e5e7eb;text-align:right;\\\">10,00<\\/td><td style=\\\"padding:8px;border:1px solid #e5e7eb;text-align:right;\\\">$195.000,00<\\/td><td style=\\\"padding:8px;border:1px solid #e5e7eb;text-align:right;\\\">$1.950.000,00<\\/td><\\/tr><\\/tbody><\\/table>\\n      <\\/div>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisar la orden en línea desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver orden de compra<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">Descargar PDF de la orden:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue enviado a javieraagonzalezmoeller@gmail.com por  ().<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"link_publico\":\"https:\\/\\/vextra.cl\\/orden-compra\\/publica\\/dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/inventario\\/ordenes-compra\\/pdf\\/1\"}', 'enviado', '2026-04-08 16:15:34'),
(20, 'vextracl@gmail.com', 'Cotización COT-069-000001 - Empresa estudio SPA', 'cotizacion_cliente_profesional', '{\"empresa\":\"Empresa estudio SPA\",\"cliente\":\"Minería del Cobre Atacama S.A.\",\"cliente_id\":3,\"numero\":\"COT-069-000001\",\"fecha_vencimiento\":\"2026-04-23\",\"total\":\"3.784.200,00\",\"remitente_correo\":\"vextracl@gmail.com\",\"remitente_nombre\":\"Empresa estudio SPA\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Minería del Cobre Atacama S.A.<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-069-000001<\\/strong> por un total de <strong>$3.784.200,00<\\/strong>, con vigencia hasta el <strong>2026-04-23<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"http:\\/\\/localhost:8000\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1\\\" style=\\\"color:#0f3d77;\\\">http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-069-000001.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzgyMyA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKEVtcHJlc2EgZXN0dWRpbyBTUEEpIFRqIEVUCkJUIC9GMSAxMSBUZiAwLjEyIDAuMzEgMC40NyByZyA0MzAgNzQ4IFRkIChDT1RJWkFDSU9OKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzM0IFRkIChOXDI2MDogQ09ULTA2OS0wMDAwMDEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MjAgVGQgKEZlY2hhOiAyMDI2LTA0LTAxKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzA2IFRkIChWYWxpZGV6OiAyMDI2LTA0LTIzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA3MjQgVGQgKFJVVDogNzcyMjIzMzMtMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzEwIFRkIChBdi4gVmljdfFhIE1hY2tlbm5hIDM0NSwgQ29uY2VwY2nzbikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjk2IFRkIChUZWxlZm9ubzogOSA0NTY3IDY3NjcpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY4MiBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiA3Ny4xMjMuNDQ1LUspIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1NiA5IDY2NjIgMzM0NCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBBdi4gSW5kdXN0cmlhbCA0NTAwLCBBbnRvZmFnYXN0YSwgQW50b2ZhZ2FzdGEpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoQ1BVLVZPTFQtVjgpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKFByb2Nlc2Fkb3IgQ29yZS1YIFY4IC0gOCBu+mNsZW9zLCAxNiBoaWxvcywgRnJlY3VlbmNpYSA0LjJHSHouIFNvY2tldCBBTTQvTEdBLikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkMjg1LjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU4NCBUZCAoJDY3OC4zMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDQwIDU1NiA1MzIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA0NCA1NjQgVGQgKExBUC1aRU4tMDEpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NjQgVGQgKExhcHRvcCBaZW5pdCB2MTQgUHJvIC0gQ1BVIFF1YWQtQ29yZSwgMTZHQiBSQU0sIFNTRCA1MTJHQi4gUGFudGFsbGEgMTQiIEZIRC4pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1NjQgVGQgKDMuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NjQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDg3MC4wMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1NjQgVGQgKCQzLjEwNS45MDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM2NyBUZCAoU3VidG90YWwpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM0NyBUZCAoRGVzY3VlbnRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzQ3IFRkICgtICQwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzIwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMjcgVGQgKE5ldG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMwNyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMDcgVGQgKCQ2MDQuMjAwKSBUaiBFVAowLjEyIDAuMzEgMC40NyByZyAzMzAgMjgwIDI0MiAyMiByZSBmCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDMzOCAyODggVGQgKFRvdGFsKSBUaiBFVApCVCAvRjEgOSBUZiAxIDEgMSByZyA1MDAgMjg4IFRkICgkMy43ODQuMjAwKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkIChDdW1wbGlyIGNvbiBsYSBhcHJvYmFjafNuL2Rlc2Fwcm9iYWNp824gZGVudHJvIGRlIGxhIGZlY2hhIHBhcmEgZWplY3V0YXJsYSBhbCBk7WEgaOFiaWwgc2lndWllbnRlIGVuIGNhc28gZGUgc2VyIGFjZXB0YWRhKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMTkwIFRkIChUZXJtaW5vcyB5IGNvbmRpY2lvbmVzKSBUaiBFVAowLjMgMC4zNSAwLjQgUkcgMSB3IDcwIDc4IG0gMjYwIDc4IGwgUwowLjMgMC4zNSAwLjQgUkcgMSB3IDM1MCA3OCBtIDU0MCA3OCBsIFMKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMTMwIDY2IFRkIChKdWFuIFBlcmV6KSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMzAgNTQgVGQgKEVqZWN1dGl2byBDb21lcmNpYWwpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQyMCA2NiBUZCAoTWluZXLtYSBkZWwgQ29icmUgQXRhY2FtYSBTLkEuKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKNDE4NgolJUVPRg==\"}],\"link_publico\":\"http:\\/\\/localhost:8000\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1\"}', 'enviado', '2026-04-10 00:55:05');
INSERT INTO `logs_correos` (`id`, `destinatario`, `asunto`, `plantilla`, `payload`, `estado`, `fecha_creacion`) VALUES
(21, 'ventas@repuestosmaule.cl', 'Cotización COT-069-000004 - Empresa estudio SPA', 'cotizacion_cliente_profesional', '{\"empresa\":\"Empresa estudio SPA\",\"cliente\":\"Comercializadora de Repuestos Maule SpA\",\"cliente_id\":6,\"numero\":\"COT-069-000004\",\"fecha_vencimiento\":\"2026-04-11\",\"total\":\"4.879.000,00\",\"remitente_correo\":\"vextracl@gmail.com\",\"remitente_nombre\":\"Empresa estudio SPA\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Comercializadora de Repuestos Maule SpA<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-069-000004<\\/strong> por un total de <strong>$4.879.000,00<\\/strong>, con vigencia hasta el <strong>2026-04-11<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"http:\\/\\/localhost:8000\\/cotizacion\\/publica\\/10845f751d4caa58f79924a009600e3a4a4b9ad41f7d3812c1fa42b77aa983f5\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/4\\\" style=\\\"color:#0f3d77;\\\">http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/4<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-069-000004.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggNDI2MiA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKEVtcHJlc2EgZXN0dWRpbyBTUEEpIFRqIEVUCkJUIC9GMSAxMSBUZiAwLjEyIDAuMzEgMC40NyByZyA0MzAgNzQ4IFRkIChDT1RJWkFDSU9OKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzM0IFRkIChOXDI2MDogQ09ULTA2OS0wMDAwMDQpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MjAgVGQgKEZlY2hhOiAyMDI2LTA0LTA5KSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzA2IFRkIChWYWxpZGV6OiAyMDI2LTA0LTExKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA3MjQgVGQgKFJVVDogNzcyMjIzMzMtMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzEwIFRkIChBdi4gVmljdfFhIE1hY2tlbm5hIDM0NSwgQ29uY2VwY2nzbikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjk2IFRkIChUZWxlZm9ubzogOSA0NTY3IDY3NjcpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY4MiBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IENvbWVyY2lhbGl6YWRvcmEgZGUgUmVwdWVzdG9zIE1hdWxlIFNwQSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiA3Ni45OTEuMDAyLTMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IENvbWVyY2lhbGl6YWRvcmEgZGUgUmVwdWVzdG9zIE1hdWxlIFNwQSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiB2ZW50YXNAcmVwdWVzdG9zbWF1bGUuY2wpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1NiA5IDQxMTMgNzg5MCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBDYWxsZSAxIE9yaWVudGUgNTQwLCBUYWxjYSwgVGFsY2EpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoTEFQLVpFTi0wMSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU4NCBUZCAoTGFwdG9wIFplbml0IHYxNCBQcm8gLSBDUFUgUXVhZC1Db3JlLCAxNkdCIFJBTSwgU1NEIDUxMkdCLiBQYW50YWxsYSAxNCIgRkhELikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMy4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkODcwLjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU4NCBUZCAoJDMuMTA1LjkwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTU2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU2NCBUZCAoU1JWLUNPTlMtMTAxKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMDAgNTY0IFRkIChBdWRpdG9y7WEgZGUgQ2liZXJzZWd1cmlkYWQgSW5pY2lhbCAtIEV2YWx1YWNp824gZXhoYXVzdGl2YSBkZSB2dWxuZXJhYmlsaWRhZGVzIGVuIGxhIHJlZCBsb2NhbCwgcmV2aXNp824gZGUgcG9s7XRpY2FzIGRlIGNvbnRyYXNl8WFzIHkgcmVwb3J0ZSBkZSByZWNvbWVuZGFjaW9uZXMgcGFyYSBsYSBwcm90ZWNjafNuIGRlIGRhdG9zIHNlbnNpYmxlcyBkZSBsYSBlbXByZXNhLikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU2NCBUZCAoMS4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU2NCBUZCAoaG9yYSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDY1LjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU2NCBUZCAoJDc3LjM1MCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTM2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU0NCBUZCAoQ1BVLVZPTFQtVjgpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NDQgVGQgKFByb2Nlc2Fkb3IgQ29yZS1YIFY4IC0gOCBu+mNsZW9zLCAxNiBoaWxvcywgRnJlY3VlbmNpYSA0LjJHSHouIFNvY2tldCBBTTQvTEdBLikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU0NCBUZCAoNS4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU0NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTQ0IFRkICgkMjg1LjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU0NCBUZCAoJDEuNjk1Ljc1MCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM2MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzY3IFRkIChTdWJ0b3RhbCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDM2NyBUZCAoJDQuMTAwLjAwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM0MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzQ3IFRkIChEZXNjdWVudG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNDcgVGQgKC0gJDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMyNyBUZCAoTmV0bykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMyNyBUZCAoJDQuMTAwLjAwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDMwMCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzA3IFRkIChJVkEgXCgxOSVcKSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMwNyBUZCAoJDc3OS4wMDApIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDMzMCAyODAgMjQyIDIyIHJlIGYKQlQgL0YxIDkgVGYgMSAxIDEgcmcgMzM4IDI4OCBUZCAoVG90YWwpIFRqIEVUCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDUwMCAyODggVGQgKCQ0Ljg3OS4wMDApIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAyNTggVGQgKE9ic2VydmFjaW9uZXMpIFRqIEVUCjAuOTcgMC45OCAwLjk5IHJnIDQwIDIxMCA1MzIgNDAgcmUgZgowLjEyIDAuMzEgMC40NyBSRyAyIHcgNDAgMjEwIG0gNDAgMjUwIGwgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA1MCAyMzYgVGQgKCkgVGogRVQKQlQgL0YxIDEwIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQwIDE5MCBUZCAoVGVybWlub3MgeSBjb25kaWNpb25lcykgVGogRVQKMC4zIDAuMzUgMC40IFJHIDEgdyA3MCA3OCBtIDI2MCA3OCBsIFMKMC4zIDAuMzUgMC40IFJHIDEgdyAzNTAgNzggbSA1NDAgNzggbCBTCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDEzMCA2NiBUZCAoSnVhbiBQZXJleikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTMwIDU0IFRkIChFamVjdXRpdm8gQ29tZXJjaWFsKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MjAgNjYgVGQgKENvbWVyY2lhbGl6YWRvcmEgZGUgUmVwdWVzdG9zIE1hdWxlIFNwQSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDEwIDU0IFRkIChBY2VwdGFjaW9uIGNsaWVudGUpIFRqIEVUCkJUIC9GMSA3IFRmIDAuNCAwLjQ1IDAuNSByZyAyMTAgMzYgVGQgKERvY3VtZW50byBnZW5lcmFkbyBhdXRvbWF0aWNhbWVudGUgcG9yIGVsIHNpc3RlbWEgZGUgY290aXphY2lvbmVzLikgVGogRVQKZW5kc3RyZWFtIGVuZG9iagp4cmVmCjAgNgowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAwMDAwMDkgMDAwMDAgbiAKMDAwMDAwMDA1OCAwMDAwMCBuIAowMDAwMDAwMTE1IDAwMDAwIG4gCjAwMDAwMDAyNDEgMDAwMDAgbiAKMDAwMDAwMDMxMSAwMDAwMCBuIAp0cmFpbGVyIDw8IC9TaXplIDYgL1Jvb3QgMSAwIFIgPj4Kc3RhcnR4cmVmCjQ2MjUKJSVFT0Y=\"}],\"link_publico\":\"http:\\/\\/localhost:8000\\/cotizacion\\/publica\\/10845f751d4caa58f79924a009600e3a4a4b9ad41f7d3812c1fa42b77aa983f5\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/4\"}', 'enviado', '2026-04-10 00:57:45'),
(22, 'vextracl@gmail.com', 'Cotización COT-069-000001 - Empresa estudio SPA', 'cotizacion_cliente_profesional', '{\"empresa\":\"Empresa estudio SPA\",\"cliente\":\"Minería del Cobre Atacama S.A.\",\"cliente_id\":3,\"numero\":\"COT-069-000001\",\"fecha_vencimiento\":\"2026-04-23\",\"total\":\"3.784.200,00\",\"remitente_correo\":\"vextracl@gmail.com\",\"remitente_nombre\":\"Empresa estudio SPA\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Minería del Cobre Atacama S.A.<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-069-000001<\\/strong> por un total de <strong>$3.784.200,00<\\/strong>, con vigencia hasta el <strong>2026-04-23<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1\\\" style=\\\"color:#0f3d77;\\\">http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-069-000001.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzgyMyA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKEVtcHJlc2EgZXN0dWRpbyBTUEEpIFRqIEVUCkJUIC9GMSAxMSBUZiAwLjEyIDAuMzEgMC40NyByZyA0MzAgNzQ4IFRkIChDT1RJWkFDSU9OKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzM0IFRkIChOXDI2MDogQ09ULTA2OS0wMDAwMDEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MjAgVGQgKEZlY2hhOiAyMDI2LTA0LTAxKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzA2IFRkIChWYWxpZGV6OiAyMDI2LTA0LTIzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA3MjQgVGQgKFJVVDogNzcyMjIzMzMtMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzEwIFRkIChBdi4gVmljdfFhIE1hY2tlbm5hIDM0NSwgQ29uY2VwY2nzbikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjk2IFRkIChUZWxlZm9ubzogOSA0NTY3IDY3NjcpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY4MiBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiA3Ny4xMjMuNDQ1LUspIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1NiA5IDY2NjIgMzM0NCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBBdi4gSW5kdXN0cmlhbCA0NTAwLCBBbnRvZmFnYXN0YSwgQW50b2ZhZ2FzdGEpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoQ1BVLVZPTFQtVjgpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKFByb2Nlc2Fkb3IgQ29yZS1YIFY4IC0gOCBu+mNsZW9zLCAxNiBoaWxvcywgRnJlY3VlbmNpYSA0LjJHSHouIFNvY2tldCBBTTQvTEdBLikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkMjg1LjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU4NCBUZCAoJDY3OC4zMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDQwIDU1NiA1MzIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA0NCA1NjQgVGQgKExBUC1aRU4tMDEpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NjQgVGQgKExhcHRvcCBaZW5pdCB2MTQgUHJvIC0gQ1BVIFF1YWQtQ29yZSwgMTZHQiBSQU0sIFNTRCA1MTJHQi4gUGFudGFsbGEgMTQiIEZIRC4pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1NjQgVGQgKDMuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NjQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDg3MC4wMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1NjQgVGQgKCQzLjEwNS45MDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM2NyBUZCAoU3VidG90YWwpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM0NyBUZCAoRGVzY3VlbnRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzQ3IFRkICgtICQwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzIwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMjcgVGQgKE5ldG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMwNyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMDcgVGQgKCQ2MDQuMjAwKSBUaiBFVAowLjEyIDAuMzEgMC40NyByZyAzMzAgMjgwIDI0MiAyMiByZSBmCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDMzOCAyODggVGQgKFRvdGFsKSBUaiBFVApCVCAvRjEgOSBUZiAxIDEgMSByZyA1MDAgMjg4IFRkICgkMy43ODQuMjAwKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkIChDdW1wbGlyIGNvbiBsYSBhcHJvYmFjafNuL2Rlc2Fwcm9iYWNp824gZGVudHJvIGRlIGxhIGZlY2hhIHBhcmEgZWplY3V0YXJsYSBhbCBk7WEgaOFiaWwgc2lndWllbnRlIGVuIGNhc28gZGUgc2VyIGFjZXB0YWRhKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMTkwIFRkIChUZXJtaW5vcyB5IGNvbmRpY2lvbmVzKSBUaiBFVAowLjMgMC4zNSAwLjQgUkcgMSB3IDcwIDc4IG0gMjYwIDc4IGwgUwowLjMgMC4zNSAwLjQgUkcgMSB3IDM1MCA3OCBtIDU0MCA3OCBsIFMKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMTMwIDY2IFRkIChKdWFuIFBlcmV6KSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMzAgNTQgVGQgKEVqZWN1dGl2byBDb21lcmNpYWwpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQyMCA2NiBUZCAoTWluZXLtYSBkZWwgQ29icmUgQXRhY2FtYSBTLkEuKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKNDE4NgolJUVPRg==\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1\"}', 'enviado', '2026-04-10 01:05:32'),
(23, 'vextracl@gmail.com', 'Cotización COT-069-000001 - Empresa estudio SPA', 'cotizacion_cliente_profesional', '{\"empresa\":\"Empresa estudio SPA\",\"cliente\":\"Minería del Cobre Atacama S.A.\",\"cliente_id\":3,\"numero\":\"COT-069-000001\",\"fecha_vencimiento\":\"2026-04-23\",\"total\":\"3.784.200,00\",\"remitente_correo\":\"vextracl@gmail.com\",\"remitente_nombre\":\"Empresa estudio SPA\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Minería del Cobre Atacama S.A.<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-069-000001<\\/strong> por un total de <strong>$3.784.200,00<\\/strong>, con vigencia hasta el <strong>2026-04-23<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1\\\" style=\\\"color:#0f3d77;\\\">http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-069-000001.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzgyMyA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKEVtcHJlc2EgZXN0dWRpbyBTUEEpIFRqIEVUCkJUIC9GMSAxMSBUZiAwLjEyIDAuMzEgMC40NyByZyA0MzAgNzQ4IFRkIChDT1RJWkFDSU9OKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzM0IFRkIChOXDI2MDogQ09ULTA2OS0wMDAwMDEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MjAgVGQgKEZlY2hhOiAyMDI2LTA0LTAxKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzA2IFRkIChWYWxpZGV6OiAyMDI2LTA0LTIzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA3MjQgVGQgKFJVVDogNzcyMjIzMzMtMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzEwIFRkIChBdi4gVmljdfFhIE1hY2tlbm5hIDM0NSwgQ29uY2VwY2nzbikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjk2IFRkIChUZWxlZm9ubzogOSA0NTY3IDY3NjcpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY4MiBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiA3Ny4xMjMuNDQ1LUspIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1NiA5IDY2NjIgMzM0NCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBBdi4gSW5kdXN0cmlhbCA0NTAwLCBBbnRvZmFnYXN0YSwgQW50b2ZhZ2FzdGEpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoQ1BVLVZPTFQtVjgpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKFByb2Nlc2Fkb3IgQ29yZS1YIFY4IC0gOCBu+mNsZW9zLCAxNiBoaWxvcywgRnJlY3VlbmNpYSA0LjJHSHouIFNvY2tldCBBTTQvTEdBLikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkMjg1LjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU4NCBUZCAoJDY3OC4zMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDQwIDU1NiA1MzIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA0NCA1NjQgVGQgKExBUC1aRU4tMDEpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NjQgVGQgKExhcHRvcCBaZW5pdCB2MTQgUHJvIC0gQ1BVIFF1YWQtQ29yZSwgMTZHQiBSQU0sIFNTRCA1MTJHQi4gUGFudGFsbGEgMTQiIEZIRC4pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1NjQgVGQgKDMuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NjQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDg3MC4wMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1NjQgVGQgKCQzLjEwNS45MDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM2NyBUZCAoU3VidG90YWwpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM0NyBUZCAoRGVzY3VlbnRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzQ3IFRkICgtICQwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzIwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMjcgVGQgKE5ldG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMwNyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMDcgVGQgKCQ2MDQuMjAwKSBUaiBFVAowLjEyIDAuMzEgMC40NyByZyAzMzAgMjgwIDI0MiAyMiByZSBmCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDMzOCAyODggVGQgKFRvdGFsKSBUaiBFVApCVCAvRjEgOSBUZiAxIDEgMSByZyA1MDAgMjg4IFRkICgkMy43ODQuMjAwKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkIChDdW1wbGlyIGNvbiBsYSBhcHJvYmFjafNuL2Rlc2Fwcm9iYWNp824gZGVudHJvIGRlIGxhIGZlY2hhIHBhcmEgZWplY3V0YXJsYSBhbCBk7WEgaOFiaWwgc2lndWllbnRlIGVuIGNhc28gZGUgc2VyIGFjZXB0YWRhKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMTkwIFRkIChUZXJtaW5vcyB5IGNvbmRpY2lvbmVzKSBUaiBFVAowLjMgMC4zNSAwLjQgUkcgMSB3IDcwIDc4IG0gMjYwIDc4IGwgUwowLjMgMC4zNSAwLjQgUkcgMSB3IDM1MCA3OCBtIDU0MCA3OCBsIFMKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMTMwIDY2IFRkIChKdWFuIFBlcmV6KSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMzAgNTQgVGQgKEVqZWN1dGl2byBDb21lcmNpYWwpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQyMCA2NiBUZCAoTWluZXLtYSBkZWwgQ29icmUgQXRhY2FtYSBTLkEuKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKNDE4NgolJUVPRg==\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1\"}', 'enviado', '2026-04-10 01:05:49'),
(24, 'vextracl@gmail.com', 'Cotización COT-069-000001 - Empresa estudio SPA', 'cotizacion_cliente_profesional', '{\"empresa\":\"Empresa estudio SPA\",\"cliente\":\"Minería del Cobre Atacama S.A.\",\"cliente_id\":3,\"numero\":\"COT-069-000001\",\"fecha_vencimiento\":\"2026-04-23\",\"total\":\"3.784.200,00\",\"remitente_correo\":\"vextracl@gmail.com\",\"remitente_nombre\":\"Empresa estudio SPA\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Minería del Cobre Atacama S.A.<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-069-000001<\\/strong> por un total de <strong>$3.784.200,00<\\/strong>, con vigencia hasta el <strong>2026-04-23<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1\\\" style=\\\"color:#0f3d77;\\\">http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-069-000001.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzgyMyA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKEVtcHJlc2EgZXN0dWRpbyBTUEEpIFRqIEVUCkJUIC9GMSAxMSBUZiAwLjEyIDAuMzEgMC40NyByZyA0MzAgNzQ4IFRkIChDT1RJWkFDSU9OKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzM0IFRkIChOXDI2MDogQ09ULTA2OS0wMDAwMDEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MjAgVGQgKEZlY2hhOiAyMDI2LTA0LTAxKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzA2IFRkIChWYWxpZGV6OiAyMDI2LTA0LTIzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA3MjQgVGQgKFJVVDogNzcyMjIzMzMtMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzEwIFRkIChBdi4gVmljdfFhIE1hY2tlbm5hIDM0NSwgQ29uY2VwY2nzbikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjk2IFRkIChUZWxlZm9ubzogOSA0NTY3IDY3NjcpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY4MiBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiA3Ny4xMjMuNDQ1LUspIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1NiA5IDY2NjIgMzM0NCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBBdi4gSW5kdXN0cmlhbCA0NTAwLCBBbnRvZmFnYXN0YSwgQW50b2ZhZ2FzdGEpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoQ1BVLVZPTFQtVjgpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKFByb2Nlc2Fkb3IgQ29yZS1YIFY4IC0gOCBu+mNsZW9zLCAxNiBoaWxvcywgRnJlY3VlbmNpYSA0LjJHSHouIFNvY2tldCBBTTQvTEdBLikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkMjg1LjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU4NCBUZCAoJDY3OC4zMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDQwIDU1NiA1MzIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA0NCA1NjQgVGQgKExBUC1aRU4tMDEpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NjQgVGQgKExhcHRvcCBaZW5pdCB2MTQgUHJvIC0gQ1BVIFF1YWQtQ29yZSwgMTZHQiBSQU0sIFNTRCA1MTJHQi4gUGFudGFsbGEgMTQiIEZIRC4pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1NjQgVGQgKDMuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NjQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDg3MC4wMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1NjQgVGQgKCQzLjEwNS45MDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM2NyBUZCAoU3VidG90YWwpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM0NyBUZCAoRGVzY3VlbnRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzQ3IFRkICgtICQwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzIwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMjcgVGQgKE5ldG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMwNyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMDcgVGQgKCQ2MDQuMjAwKSBUaiBFVAowLjEyIDAuMzEgMC40NyByZyAzMzAgMjgwIDI0MiAyMiByZSBmCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDMzOCAyODggVGQgKFRvdGFsKSBUaiBFVApCVCAvRjEgOSBUZiAxIDEgMSByZyA1MDAgMjg4IFRkICgkMy43ODQuMjAwKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkIChDdW1wbGlyIGNvbiBsYSBhcHJvYmFjafNuL2Rlc2Fwcm9iYWNp824gZGVudHJvIGRlIGxhIGZlY2hhIHBhcmEgZWplY3V0YXJsYSBhbCBk7WEgaOFiaWwgc2lndWllbnRlIGVuIGNhc28gZGUgc2VyIGFjZXB0YWRhKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMTkwIFRkIChUZXJtaW5vcyB5IGNvbmRpY2lvbmVzKSBUaiBFVAowLjMgMC4zNSAwLjQgUkcgMSB3IDcwIDc4IG0gMjYwIDc4IGwgUwowLjMgMC4zNSAwLjQgUkcgMSB3IDM1MCA3OCBtIDU0MCA3OCBsIFMKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMTMwIDY2IFRkIChKdWFuIFBlcmV6KSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMzAgNTQgVGQgKEVqZWN1dGl2byBDb21lcmNpYWwpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQyMCA2NiBUZCAoTWluZXLtYSBkZWwgQ29icmUgQXRhY2FtYSBTLkEuKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKNDE4NgolJUVPRg==\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1\"}', 'enviado', '2026-04-10 01:06:15'),
(25, 'vextracl@gmail.com', 'Cotización COT-069-000001 - Empresa estudio SPA', 'cotizacion_cliente_profesional', '{\"empresa\":\"Empresa estudio SPA\",\"cliente\":\"Minería del Cobre Atacama S.A.\",\"cliente_id\":3,\"numero\":\"COT-069-000001\",\"fecha_vencimiento\":\"2026-04-23\",\"total\":\"3.784.200,00\",\"remitente_correo\":\"vextracl@gmail.com\",\"remitente_nombre\":\"Empresa estudio SPA\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Minería del Cobre Atacama S.A.<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-069-000001<\\/strong> por un total de <strong>$3.784.200,00<\\/strong>, con vigencia hasta el <strong>2026-04-23<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1\\\" style=\\\"color:#0f3d77;\\\">http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-069-000001.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzgyMyA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKEVtcHJlc2EgZXN0dWRpbyBTUEEpIFRqIEVUCkJUIC9GMSAxMSBUZiAwLjEyIDAuMzEgMC40NyByZyA0MzAgNzQ4IFRkIChDT1RJWkFDSU9OKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzM0IFRkIChOXDI2MDogQ09ULTA2OS0wMDAwMDEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MjAgVGQgKEZlY2hhOiAyMDI2LTA0LTAxKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzA2IFRkIChWYWxpZGV6OiAyMDI2LTA0LTIzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA3MjQgVGQgKFJVVDogNzcyMjIzMzMtMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzEwIFRkIChBdi4gVmljdfFhIE1hY2tlbm5hIDM0NSwgQ29uY2VwY2nzbikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjk2IFRkIChUZWxlZm9ubzogOSA0NTY3IDY3NjcpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY4MiBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiA3Ny4xMjMuNDQ1LUspIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1NiA5IDY2NjIgMzM0NCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBBdi4gSW5kdXN0cmlhbCA0NTAwLCBBbnRvZmFnYXN0YSwgQW50b2ZhZ2FzdGEpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoQ1BVLVZPTFQtVjgpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKFByb2Nlc2Fkb3IgQ29yZS1YIFY4IC0gOCBu+mNsZW9zLCAxNiBoaWxvcywgRnJlY3VlbmNpYSA0LjJHSHouIFNvY2tldCBBTTQvTEdBLikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkMjg1LjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU4NCBUZCAoJDY3OC4zMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDQwIDU1NiA1MzIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA0NCA1NjQgVGQgKExBUC1aRU4tMDEpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NjQgVGQgKExhcHRvcCBaZW5pdCB2MTQgUHJvIC0gQ1BVIFF1YWQtQ29yZSwgMTZHQiBSQU0sIFNTRCA1MTJHQi4gUGFudGFsbGEgMTQiIEZIRC4pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1NjQgVGQgKDMuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NjQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDg3MC4wMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1NjQgVGQgKCQzLjEwNS45MDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM2NyBUZCAoU3VidG90YWwpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM0NyBUZCAoRGVzY3VlbnRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzQ3IFRkICgtICQwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzIwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMjcgVGQgKE5ldG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMwNyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMDcgVGQgKCQ2MDQuMjAwKSBUaiBFVAowLjEyIDAuMzEgMC40NyByZyAzMzAgMjgwIDI0MiAyMiByZSBmCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDMzOCAyODggVGQgKFRvdGFsKSBUaiBFVApCVCAvRjEgOSBUZiAxIDEgMSByZyA1MDAgMjg4IFRkICgkMy43ODQuMjAwKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkIChDdW1wbGlyIGNvbiBsYSBhcHJvYmFjafNuL2Rlc2Fwcm9iYWNp824gZGVudHJvIGRlIGxhIGZlY2hhIHBhcmEgZWplY3V0YXJsYSBhbCBk7WEgaOFiaWwgc2lndWllbnRlIGVuIGNhc28gZGUgc2VyIGFjZXB0YWRhKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMTkwIFRkIChUZXJtaW5vcyB5IGNvbmRpY2lvbmVzKSBUaiBFVAowLjMgMC4zNSAwLjQgUkcgMSB3IDcwIDc4IG0gMjYwIDc4IGwgUwowLjMgMC4zNSAwLjQgUkcgMSB3IDM1MCA3OCBtIDU0MCA3OCBsIFMKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMTMwIDY2IFRkIChKdWFuIFBlcmV6KSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMzAgNTQgVGQgKEVqZWN1dGl2byBDb21lcmNpYWwpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQyMCA2NiBUZCAoTWluZXLtYSBkZWwgQ29icmUgQXRhY2FtYSBTLkEuKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKNDE4NgolJUVPRg==\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1\"}', 'enviado', '2026-04-10 01:06:24');
INSERT INTO `logs_correos` (`id`, `destinatario`, `asunto`, `plantilla`, `payload`, `estado`, `fecha_creacion`) VALUES
(26, 'ventas@repuestosmaule.cl', 'Cotización COT-069-000004 - Empresa estudio SPA', 'cotizacion_cliente_profesional', '{\"empresa\":\"Empresa estudio SPA\",\"cliente\":\"Comercializadora de Repuestos Maule SpA\",\"cliente_id\":6,\"numero\":\"COT-069-000004\",\"fecha_vencimiento\":\"2026-04-11\",\"total\":\"4.879.000,00\",\"remitente_correo\":\"vextracl@gmail.com\",\"remitente_nombre\":\"Empresa estudio SPA\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Comercializadora de Repuestos Maule SpA<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-069-000004<\\/strong> por un total de <strong>$4.879.000,00<\\/strong>, con vigencia hasta el <strong>2026-04-11<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/10845f751d4caa58f79924a009600e3a4a4b9ad41f7d3812c1fa42b77aa983f5\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/4\\\" style=\\\"color:#0f3d77;\\\">http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/4<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-069-000004.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggNDI2MiA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKEVtcHJlc2EgZXN0dWRpbyBTUEEpIFRqIEVUCkJUIC9GMSAxMSBUZiAwLjEyIDAuMzEgMC40NyByZyA0MzAgNzQ4IFRkIChDT1RJWkFDSU9OKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzM0IFRkIChOXDI2MDogQ09ULTA2OS0wMDAwMDQpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MjAgVGQgKEZlY2hhOiAyMDI2LTA0LTA5KSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzA2IFRkIChWYWxpZGV6OiAyMDI2LTA0LTExKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA3MjQgVGQgKFJVVDogNzcyMjIzMzMtMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzEwIFRkIChBdi4gVmljdfFhIE1hY2tlbm5hIDM0NSwgQ29uY2VwY2nzbikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjk2IFRkIChUZWxlZm9ubzogOSA0NTY3IDY3NjcpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY4MiBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IENvbWVyY2lhbGl6YWRvcmEgZGUgUmVwdWVzdG9zIE1hdWxlIFNwQSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiA3Ni45OTEuMDAyLTMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IENvbWVyY2lhbGl6YWRvcmEgZGUgUmVwdWVzdG9zIE1hdWxlIFNwQSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiB2ZW50YXNAcmVwdWVzdG9zbWF1bGUuY2wpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1NiA5IDQxMTMgNzg5MCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBDYWxsZSAxIE9yaWVudGUgNTQwLCBUYWxjYSwgVGFsY2EpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoTEFQLVpFTi0wMSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU4NCBUZCAoTGFwdG9wIFplbml0IHYxNCBQcm8gLSBDUFUgUXVhZC1Db3JlLCAxNkdCIFJBTSwgU1NEIDUxMkdCLiBQYW50YWxsYSAxNCIgRkhELikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMy4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkODcwLjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU4NCBUZCAoJDMuMTA1LjkwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTU2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU2NCBUZCAoU1JWLUNPTlMtMTAxKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMDAgNTY0IFRkIChBdWRpdG9y7WEgZGUgQ2liZXJzZWd1cmlkYWQgSW5pY2lhbCAtIEV2YWx1YWNp824gZXhoYXVzdGl2YSBkZSB2dWxuZXJhYmlsaWRhZGVzIGVuIGxhIHJlZCBsb2NhbCwgcmV2aXNp824gZGUgcG9s7XRpY2FzIGRlIGNvbnRyYXNl8WFzIHkgcmVwb3J0ZSBkZSByZWNvbWVuZGFjaW9uZXMgcGFyYSBsYSBwcm90ZWNjafNuIGRlIGRhdG9zIHNlbnNpYmxlcyBkZSBsYSBlbXByZXNhLikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU2NCBUZCAoMS4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU2NCBUZCAoaG9yYSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDY1LjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU2NCBUZCAoJDc3LjM1MCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTM2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU0NCBUZCAoQ1BVLVZPTFQtVjgpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NDQgVGQgKFByb2Nlc2Fkb3IgQ29yZS1YIFY4IC0gOCBu+mNsZW9zLCAxNiBoaWxvcywgRnJlY3VlbmNpYSA0LjJHSHouIFNvY2tldCBBTTQvTEdBLikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU0NCBUZCAoNS4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU0NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTQ0IFRkICgkMjg1LjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU0NCBUZCAoJDEuNjk1Ljc1MCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM2MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzY3IFRkIChTdWJ0b3RhbCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDM2NyBUZCAoJDQuMTAwLjAwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM0MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzQ3IFRkIChEZXNjdWVudG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNDcgVGQgKC0gJDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMyNyBUZCAoTmV0bykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMyNyBUZCAoJDQuMTAwLjAwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDMwMCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzA3IFRkIChJVkEgXCgxOSVcKSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMwNyBUZCAoJDc3OS4wMDApIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDMzMCAyODAgMjQyIDIyIHJlIGYKQlQgL0YxIDkgVGYgMSAxIDEgcmcgMzM4IDI4OCBUZCAoVG90YWwpIFRqIEVUCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDUwMCAyODggVGQgKCQ0Ljg3OS4wMDApIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAyNTggVGQgKE9ic2VydmFjaW9uZXMpIFRqIEVUCjAuOTcgMC45OCAwLjk5IHJnIDQwIDIxMCA1MzIgNDAgcmUgZgowLjEyIDAuMzEgMC40NyBSRyAyIHcgNDAgMjEwIG0gNDAgMjUwIGwgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA1MCAyMzYgVGQgKCkgVGogRVQKQlQgL0YxIDEwIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQwIDE5MCBUZCAoVGVybWlub3MgeSBjb25kaWNpb25lcykgVGogRVQKMC4zIDAuMzUgMC40IFJHIDEgdyA3MCA3OCBtIDI2MCA3OCBsIFMKMC4zIDAuMzUgMC40IFJHIDEgdyAzNTAgNzggbSA1NDAgNzggbCBTCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDEzMCA2NiBUZCAoSnVhbiBQZXJleikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTMwIDU0IFRkIChFamVjdXRpdm8gQ29tZXJjaWFsKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MjAgNjYgVGQgKENvbWVyY2lhbGl6YWRvcmEgZGUgUmVwdWVzdG9zIE1hdWxlIFNwQSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDEwIDU0IFRkIChBY2VwdGFjaW9uIGNsaWVudGUpIFRqIEVUCkJUIC9GMSA3IFRmIDAuNCAwLjQ1IDAuNSByZyAyMTAgMzYgVGQgKERvY3VtZW50byBnZW5lcmFkbyBhdXRvbWF0aWNhbWVudGUgcG9yIGVsIHNpc3RlbWEgZGUgY290aXphY2lvbmVzLikgVGogRVQKZW5kc3RyZWFtIGVuZG9iagp4cmVmCjAgNgowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAwMDAwMDkgMDAwMDAgbiAKMDAwMDAwMDA1OCAwMDAwMCBuIAowMDAwMDAwMTE1IDAwMDAwIG4gCjAwMDAwMDAyNDEgMDAwMDAgbiAKMDAwMDAwMDMxMSAwMDAwMCBuIAp0cmFpbGVyIDw8IC9TaXplIDYgL1Jvb3QgMSAwIFIgPj4Kc3RhcnR4cmVmCjQ2MjUKJSVFT0Y=\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/10845f751d4caa58f79924a009600e3a4a4b9ad41f7d3812c1fa42b77aa983f5\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/4\"}', 'enviado', '2026-04-10 01:34:59'),
(27, 'vextracl@gmail.com', 'Cotización COT-069-000001 - Empresa estudio SPA', 'cotizacion_cliente_profesional', '{\"empresa\":\"Empresa estudio SPA\",\"cliente\":\"Minería del Cobre Atacama S.A.\",\"cliente_id\":3,\"numero\":\"COT-069-000001\",\"fecha_vencimiento\":\"2026-04-23\",\"total\":\"3.784.200,00\",\"remitente_correo\":\"vextracl@gmail.com\",\"remitente_nombre\":\"Empresa estudio SPA\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Minería del Cobre Atacama S.A.<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-069-000001<\\/strong> por un total de <strong>$3.784.200,00<\\/strong>, con vigencia hasta el <strong>2026-04-23<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1\\\" style=\\\"color:#0f3d77;\\\">http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-069-000001.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzgyMyA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKEVtcHJlc2EgZXN0dWRpbyBTUEEpIFRqIEVUCkJUIC9GMSAxMSBUZiAwLjEyIDAuMzEgMC40NyByZyA0MzAgNzQ4IFRkIChDT1RJWkFDSU9OKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzM0IFRkIChOXDI2MDogQ09ULTA2OS0wMDAwMDEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MjAgVGQgKEZlY2hhOiAyMDI2LTA0LTAxKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzA2IFRkIChWYWxpZGV6OiAyMDI2LTA0LTIzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA3MjQgVGQgKFJVVDogNzcyMjIzMzMtMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzEwIFRkIChBdi4gVmljdfFhIE1hY2tlbm5hIDM0NSwgQ29uY2VwY2nzbikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjk2IFRkIChUZWxlZm9ubzogOSA0NTY3IDY3NjcpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY4MiBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiA3Ny4xMjMuNDQ1LUspIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1NiA5IDY2NjIgMzM0NCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBBdi4gSW5kdXN0cmlhbCA0NTAwLCBBbnRvZmFnYXN0YSwgQW50b2ZhZ2FzdGEpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoQ1BVLVZPTFQtVjgpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKFByb2Nlc2Fkb3IgQ29yZS1YIFY4IC0gOCBu+mNsZW9zLCAxNiBoaWxvcywgRnJlY3VlbmNpYSA0LjJHSHouIFNvY2tldCBBTTQvTEdBLikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkMjg1LjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU4NCBUZCAoJDY3OC4zMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDQwIDU1NiA1MzIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA0NCA1NjQgVGQgKExBUC1aRU4tMDEpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NjQgVGQgKExhcHRvcCBaZW5pdCB2MTQgUHJvIC0gQ1BVIFF1YWQtQ29yZSwgMTZHQiBSQU0sIFNTRCA1MTJHQi4gUGFudGFsbGEgMTQiIEZIRC4pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1NjQgVGQgKDMuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NjQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDg3MC4wMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1NjQgVGQgKCQzLjEwNS45MDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM2NyBUZCAoU3VidG90YWwpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM0NyBUZCAoRGVzY3VlbnRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzQ3IFRkICgtICQwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzIwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMjcgVGQgKE5ldG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMwNyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMDcgVGQgKCQ2MDQuMjAwKSBUaiBFVAowLjEyIDAuMzEgMC40NyByZyAzMzAgMjgwIDI0MiAyMiByZSBmCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDMzOCAyODggVGQgKFRvdGFsKSBUaiBFVApCVCAvRjEgOSBUZiAxIDEgMSByZyA1MDAgMjg4IFRkICgkMy43ODQuMjAwKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkIChDdW1wbGlyIGNvbiBsYSBhcHJvYmFjafNuL2Rlc2Fwcm9iYWNp824gZGVudHJvIGRlIGxhIGZlY2hhIHBhcmEgZWplY3V0YXJsYSBhbCBk7WEgaOFiaWwgc2lndWllbnRlIGVuIGNhc28gZGUgc2VyIGFjZXB0YWRhKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMTkwIFRkIChUZXJtaW5vcyB5IGNvbmRpY2lvbmVzKSBUaiBFVAowLjMgMC4zNSAwLjQgUkcgMSB3IDcwIDc4IG0gMjYwIDc4IGwgUwowLjMgMC4zNSAwLjQgUkcgMSB3IDM1MCA3OCBtIDU0MCA3OCBsIFMKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMTMwIDY2IFRkIChKdWFuIFBlcmV6KSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMzAgNTQgVGQgKEVqZWN1dGl2byBDb21lcmNpYWwpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQyMCA2NiBUZCAoTWluZXLtYSBkZWwgQ29icmUgQXRhY2FtYSBTLkEuKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKNDE4NgolJUVPRg==\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\",\"link_pdf\":\"http:\\/\\/localhost:8000\\/app\\/cotizaciones\\/pdf\\/1\"}', 'enviado', '2026-04-10 01:41:00'),
(28, 'vextracl@gmail.com', 'Cotización COT-069-000001 - Empresa estudio SPA', 'cotizacion_cliente_profesional', '{\"empresa\":\"Empresa estudio SPA\",\"cliente\":\"Minería del Cobre Atacama S.A.\",\"cliente_id\":3,\"numero\":\"COT-069-000001\",\"fecha_vencimiento\":\"2026-04-23\",\"total\":\"3.784.200,00\",\"remitente_correo\":\"vextracl@gmail.com\",\"remitente_nombre\":\"Empresa estudio SPA\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Minería del Cobre Atacama S.A.<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-069-000001<\\/strong> por un total de <strong>$3.784.200,00<\\/strong>, con vigencia hasta el <strong>2026-04-23<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/1\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/1<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-069-000001.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzgyMyA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKEVtcHJlc2EgZXN0dWRpbyBTUEEpIFRqIEVUCkJUIC9GMSAxMSBUZiAwLjEyIDAuMzEgMC40NyByZyA0MzAgNzQ4IFRkIChDT1RJWkFDSU9OKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzM0IFRkIChOXDI2MDogQ09ULTA2OS0wMDAwMDEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MjAgVGQgKEZlY2hhOiAyMDI2LTA0LTAxKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzA2IFRkIChWYWxpZGV6OiAyMDI2LTA0LTIzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA3MjQgVGQgKFJVVDogNzcyMjIzMzMtMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzEwIFRkIChBdi4gVmljdfFhIE1hY2tlbm5hIDM0NSwgQ29uY2VwY2nzbikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjk2IFRkIChUZWxlZm9ubzogOSA0NTY3IDY3NjcpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY4MiBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiA3Ny4xMjMuNDQ1LUspIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IE1pbmVy7WEgZGVsIENvYnJlIEF0YWNhbWEgUy5BLikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1NiA5IDY2NjIgMzM0NCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBBdi4gSW5kdXN0cmlhbCA0NTAwLCBBbnRvZmFnYXN0YSwgQW50b2ZhZ2FzdGEpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoQ1BVLVZPTFQtVjgpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKFByb2Nlc2Fkb3IgQ29yZS1YIFY4IC0gOCBu+mNsZW9zLCAxNiBoaWxvcywgRnJlY3VlbmNpYSA0LjJHSHouIFNvY2tldCBBTTQvTEdBLikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkMjg1LjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU4NCBUZCAoJDY3OC4zMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDQwIDU1NiA1MzIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA0NCA1NjQgVGQgKExBUC1aRU4tMDEpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NjQgVGQgKExhcHRvcCBaZW5pdCB2MTQgUHJvIC0gQ1BVIFF1YWQtQ29yZSwgMTZHQiBSQU0sIFNTRCA1MTJHQi4gUGFudGFsbGEgMTQiIEZIRC4pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1NjQgVGQgKDMuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NjQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDg3MC4wMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1NjQgVGQgKCQzLjEwNS45MDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM2NyBUZCAoU3VidG90YWwpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM0NyBUZCAoRGVzY3VlbnRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzQ3IFRkICgtICQwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzIwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMjcgVGQgKE5ldG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMjcgVGQgKCQzLjE4MC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMwNyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMDcgVGQgKCQ2MDQuMjAwKSBUaiBFVAowLjEyIDAuMzEgMC40NyByZyAzMzAgMjgwIDI0MiAyMiByZSBmCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDMzOCAyODggVGQgKFRvdGFsKSBUaiBFVApCVCAvRjEgOSBUZiAxIDEgMSByZyA1MDAgMjg4IFRkICgkMy43ODQuMjAwKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkIChDdW1wbGlyIGNvbiBsYSBhcHJvYmFjafNuL2Rlc2Fwcm9iYWNp824gZGVudHJvIGRlIGxhIGZlY2hhIHBhcmEgZWplY3V0YXJsYSBhbCBk7WEgaOFiaWwgc2lndWllbnRlIGVuIGNhc28gZGUgc2VyIGFjZXB0YWRhKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMTkwIFRkIChUZXJtaW5vcyB5IGNvbmRpY2lvbmVzKSBUaiBFVAowLjMgMC4zNSAwLjQgUkcgMSB3IDcwIDc4IG0gMjYwIDc4IGwgUwowLjMgMC4zNSAwLjQgUkcgMSB3IDM1MCA3OCBtIDU0MCA3OCBsIFMKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMTMwIDY2IFRkIChKdWFuIFBlcmV6KSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMzAgNTQgVGQgKEVqZWN1dGl2byBDb21lcmNpYWwpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQyMCA2NiBUZCAoTWluZXLtYSBkZWwgQ29icmUgQXRhY2FtYSBTLkEuKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKNDE4NgolJUVPRg==\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/9989cd57fb86811f2bf9e27a07f7c15af06847f909b264a56e9e5c9b10864e9d\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/1\"}', 'enviado', '2026-04-10 01:48:11'),
(29, 'soledadmellazuniga@gmail.com', 'Cotización COT-073-000002 - Nombre Comercial Prueba dos', 'cotizacion_cliente_profesional', '{\"empresa\":\"Nombre Comercial Prueba dos\",\"cliente\":\"Cliente Prueba dos\",\"cliente_id\":8,\"numero\":\"COT-073-000002\",\"fecha_vencimiento\":\"2026-04-26\",\"total\":\"192.780,00\",\"remitente_correo\":\"soledadmellazuniga@gmail.com\",\"remitente_nombre\":\"Nombre Comercial Prueba dos\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Nombre Comercial Prueba dos<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Cliente Prueba dos<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-073-000002<\\/strong> por un total de <strong>$192.780,00<\\/strong>, con vigencia hasta el <strong>2026-04-26<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/ee150769c99642bf880c5e0bc52aadcddd66eedeba0bb13ad61c1ef4889ee65f\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/7\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/7<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-073-000002.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzgxMCA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKE5vbWJyZSBDb21lcmNpYWwgUHJ1ZWJhIGRvcykgVGogRVQKQlQgL0YxIDExIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQzMCA3NDggVGQgKENPVElaQUNJT04pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MzQgVGQgKE5cMjYwOiBDT1QtMDczLTAwMDAwMikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDcyMCBUZCAoRmVjaGE6IDIwMjYtMDQtMTEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MDYgVGQgKFZhbGlkZXo6IDIwMjYtMDQtMjYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcyNCBUZCAoUlVUOiAyNTEzMjE3OTUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcxMCBUZCAoUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY5NiBUZCAoVGVsZWZvbm86ICs1Njk2NTgyNzUzMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjgyIFRkIChDb3JyZW86IHNvbGVkYWRtZWxsYXp1bmlnYUBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IENsaWVudGUgUHJ1ZWJhIGRvcykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiAyMi4yMjIuMjIyLTIpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IENsaWVudGUgUHJ1ZWJhIGRvcykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiBzb2xlZGFkbWVsbGF6dW5pZ2FAZ21haWwuY29tKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MjQgVGQgKFRlbGVmb25vOiArNTY0MTIxMjM1NDUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDMwMCA2MjQgVGQgKERpcmVjY2lvbjogc2llbmEgNDU2MiwgTG9zIEFuZ2VsZXMpIFRqIEVUCkJUIC9GMSA5IFRmIDAuMTggMC41NSAwLjM1IHJnIDQwIDYwOCBUZCAoRGVzY3VlbnRvIHBvciBsaXN0YSBhcGxpY2FkbzogY2xpZW50ZSBtYXlvcmlzdGEgLSAkMTguMDAwKSBUaiBFVAowLjEyIDAuMzEgMC40NyByZyA0MCA1OTQgNTMyIDE4IHJlIGYKQlQgL0YxIDggVGYgMSAxIDEgcmcgNDQgNjAwIFRkIChDb2RpZ28pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDEwMCA2MDAgVGQgKERlc2NyaXBjaW9uKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzNDUgNjAwIFRkIChDYW50LikgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMzkwIDYwMCBUZCAoVW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA0NTAgNjAwIFRkIChQLiBVbml0YXJpbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgNTIwIDYwMCBUZCAoVG90YWwpIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDQwIDU3NiA1MzIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA0NCA1ODQgVGQgKDAxMjQ1KSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMDAgNTg0IFRkIChjdWFkZXJub3MgdW5pdmVyc2l0YXJpb3MgLSBjYXJnYWRvciB0ZWxlZm9ubykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMjAuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1ODQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU4NCBUZCAoJDIuNTAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MjIgNTg0IFRkICgkNTMuNTUwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyA0MCA1NTYgNTMyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDQgNTY0IFRkIChjMTIzKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMDAgNTY0IFRkIChjYXJnYWRvciB0ZWxlZm9ubyAtIGNhcmdhZG9yIHRlbGVmb25vKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAzNDggNTY0IFRkICgyMC4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU2NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTY0IFRkICgkNi41MDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1NjQgVGQgKCQxMzkuMjMwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzYwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzNjcgVGQgKFN1YnRvdGFsKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzY3IFRkICgkMTYyLjAwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM0MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzQ3IFRkIChEZXNjdWVudG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNDcgVGQgKC0gJDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMyNyBUZCAoRGVzYy4gcG9yIGxpc3RhKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzI3IFRkICgtICQxOC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMwNyBUZCAoTmV0bykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMwNyBUZCAoJDE2Mi4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAyODAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDI4NyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAyODcgVGQgKCQzMC43ODApIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDMzMCAyODAgMjQyIDIyIHJlIGYKQlQgL0YxIDkgVGYgMSAxIDEgcmcgMzM4IDI4OCBUZCAoVG90YWwpIFRqIEVUCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDUwMCAyODggVGQgKCQxOTIuNzgwKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkICgpIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAxOTAgVGQgKFRlcm1pbm9zIHkgY29uZGljaW9uZXMpIFRqIEVUCjAuMyAwLjM1IDAuNCBSRyAxIHcgNzAgNzggbSAyNjAgNzggbCBTCjAuMyAwLjM1IDAuNCBSRyAxIHcgMzUwIDc4IG0gNTQwIDc4IGwgUwpCVCAvRjEgOSBUZiAwIDAgMCByZyAxMzAgNjYgVGQgKHNvbGUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEzMCA1NCBUZCAoRWplY3V0aXZvIENvbWVyY2lhbCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDIwIDY2IFRkIChDbGllbnRlIFBydWViYSBkb3MpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQxMCA1NCBUZCAoQWNlcHRhY2lvbiBjbGllbnRlKSBUaiBFVApCVCAvRjEgNyBUZiAwLjQgMC40NSAwLjUgcmcgMjEwIDM2IFRkIChEb2N1bWVudG8gZ2VuZXJhZG8gYXV0b21hdGljYW1lbnRlIHBvciBlbCBzaXN0ZW1hIGRlIGNvdGl6YWNpb25lcy4pIFRqIEVUCmVuZHN0cmVhbSBlbmRvYmoKeHJlZgowIDYKMDAwMDAwMDAwMCA2NTUzNSBmIAowMDAwMDAwMDA5IDAwMDAwIG4gCjAwMDAwMDAwNTggMDAwMDAgbiAKMDAwMDAwMDExNSAwMDAwMCBuIAowMDAwMDAwMjQxIDAwMDAwIG4gCjAwMDAwMDAzMTEgMDAwMDAgbiAKdHJhaWxlciA8PCAvU2l6ZSA2IC9Sb290IDEgMCBSID4+CnN0YXJ0eHJlZgo0MTczCiUlRU9G\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/ee150769c99642bf880c5e0bc52aadcddd66eedeba0bb13ad61c1ef4889ee65f\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/7\"}', 'enviado', '2026-04-11 12:20:10'),
(30, 'soledadmellazuniga@gmail.com', 'Cotización COT-073-000003 - Nombre Comercial Prueba dos', 'cotizacion_cliente_profesional', '{\"empresa\":\"Nombre Comercial Prueba dos\",\"cliente\":\"Cliente Prueba cuatro\",\"cliente_id\":9,\"numero\":\"COT-073-000003\",\"fecha_vencimiento\":\"2026-04-26\",\"total\":\"42.840,00\",\"remitente_correo\":\"soledadmellazuniga@gmail.com\",\"remitente_nombre\":\"Nombre Comercial Prueba dos\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Nombre Comercial Prueba dos<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Cliente Prueba cuatro<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-073-000003<\\/strong> por un total de <strong>$42.840,00<\\/strong>, con vigencia hasta el <strong>2026-04-26<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/807530a17b97bc5658f50f0a5b57b198fac0802bcd089fca81ea1a64aa6de7f3\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/8\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/8<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-073-000003.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzU0NCA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKE5vbWJyZSBDb21lcmNpYWwgUHJ1ZWJhIGRvcykgVGogRVQKQlQgL0YxIDExIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQzMCA3NDggVGQgKENPVElaQUNJT04pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MzQgVGQgKE5cMjYwOiBDT1QtMDczLTAwMDAwMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDcyMCBUZCAoRmVjaGE6IDIwMjYtMDQtMTEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MDYgVGQgKFZhbGlkZXo6IDIwMjYtMDQtMjYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcyNCBUZCAoUlVUOiAyNTEzMjE3OTUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcxMCBUZCAoUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY5NiBUZCAoVGVsZWZvbm86ICs1Njk2NTgyNzUzMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjgyIFRkIChDb3JyZW86IHNvbGVkYWRtZWxsYXp1bmlnYUBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IENsaWVudGUgUHJ1ZWJhIGN1YXRybykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiAzMy4zMzMuMzMzLTMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IENsaWVudGUgUHJ1ZWJhIGN1YXRybykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiBzb2xlZGFkbWVsbGF6dW5pZ2FAZ21haWwuY29tKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MjQgVGQgKFRlbGVmb25vOiArNTY0NTEyMjU2MTMxMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBSb21hIDEyMywgQXJpY2EpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoMjMyMSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU4NCBUZCAocGx1bW9uIGRlIGNhbWEgMiBwbGF6YXMgLSBwbHVtb24gY2FtYSAxIDEvMikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMS4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkMTguMDAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MjIgNTg0IFRkICgkMjEuNDIwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyA0MCA1NTYgNTMyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDQgNTY0IFRkICgwMjMpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NjQgVGQgKHNhYmFuYXMgMSAxLzIgLSBzYWJhbmFzIGRlIDEgMS8yKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAzNDggNTY0IFRkICgxLjAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAzOTIgNTY0IFRkICh1bmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ1MiA1NjQgVGQgKCQxOC4wMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1NjQgVGQgKCQyMS40MjApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM2NyBUZCAoU3VidG90YWwpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNjcgVGQgKCQzNi4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM0NyBUZCAoRGVzY3VlbnRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzQ3IFRkICgtICQwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzIwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMjcgVGQgKE5ldG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMjcgVGQgKCQzNi4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMwNyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMDcgVGQgKCQ2Ljg0MCkgVGogRVQKMC4xMiAwLjMxIDAuNDcgcmcgMzMwIDI4MCAyNDIgMjIgcmUgZgpCVCAvRjEgOSBUZiAxIDEgMSByZyAzMzggMjg4IFRkIChUb3RhbCkgVGogRVQKQlQgL0YxIDkgVGYgMSAxIDEgcmcgNTAwIDI4OCBUZCAoJDQyLjg0MCkgVGogRVQKQlQgL0YxIDEwIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQwIDI1OCBUZCAoT2JzZXJ2YWNpb25lcykgVGogRVQKMC45NyAwLjk4IDAuOTkgcmcgNDAgMjEwIDUzMiA0MCByZSBmCjAuMTIgMC4zMSAwLjQ3IFJHIDIgdyA0MCAyMTAgbSA0MCAyNTAgbCBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwIDIzNiBUZCAoKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMTkwIFRkIChUZXJtaW5vcyB5IGNvbmRpY2lvbmVzKSBUaiBFVAowLjMgMC4zNSAwLjQgUkcgMSB3IDcwIDc4IG0gMjYwIDc4IGwgUwowLjMgMC4zNSAwLjQgUkcgMSB3IDM1MCA3OCBtIDU0MCA3OCBsIFMKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMTMwIDY2IFRkIChzb2xlKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMzAgNTQgVGQgKEVqZWN1dGl2byBDb21lcmNpYWwpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQyMCA2NiBUZCAoQ2xpZW50ZSBQcnVlYmEgY3VhdHJvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKMzkwNwolJUVPRg==\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/807530a17b97bc5658f50f0a5b57b198fac0802bcd089fca81ea1a64aa6de7f3\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/8\"}', 'enviado', '2026-04-11 13:37:51');
INSERT INTO `logs_correos` (`id`, `destinatario`, `asunto`, `plantilla`, `payload`, `estado`, `fecha_creacion`) VALUES
(31, 'soledadmellazuniga@gmail.com', 'Cotización COT-073-000004 - Nombre Comercial Prueba dos', 'cotizacion_cliente_profesional', '{\"empresa\":\"Nombre Comercial Prueba dos\",\"cliente\":\"Cliente Prueba cuatro\",\"cliente_id\":9,\"numero\":\"COT-073-000004\",\"fecha_vencimiento\":\"2026-04-26\",\"total\":\"76.160,00\",\"remitente_correo\":\"soledadmellazuniga@gmail.com\",\"remitente_nombre\":\"Nombre Comercial Prueba dos\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Nombre Comercial Prueba dos<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Cliente Prueba cuatro<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-073-000004<\\/strong> por un total de <strong>$76.160,00<\\/strong>, con vigencia hasta el <strong>2026-04-26<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/c095525847379fe79af9f55ffb523aa1aba91ad80c3f93d66fa780fa6bd8f2e4\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/9\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/9<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-073-000004.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzUzNyA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKE5vbWJyZSBDb21lcmNpYWwgUHJ1ZWJhIGRvcykgVGogRVQKQlQgL0YxIDExIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQzMCA3NDggVGQgKENPVElaQUNJT04pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MzQgVGQgKE5cMjYwOiBDT1QtMDczLTAwMDAwNCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDcyMCBUZCAoRmVjaGE6IDIwMjYtMDQtMTEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MDYgVGQgKFZhbGlkZXo6IDIwMjYtMDQtMjYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcyNCBUZCAoUlVUOiAyNTEzMjE3OTUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcxMCBUZCAoUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY5NiBUZCAoVGVsZWZvbm86ICs1Njk2NTgyNzUzMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjgyIFRkIChDb3JyZW86IHNvbGVkYWRtZWxsYXp1bmlnYUBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IENsaWVudGUgUHJ1ZWJhIGN1YXRybykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiAzMy4zMzMuMzMzLTMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IENsaWVudGUgUHJ1ZWJhIGN1YXRybykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiBzb2xlZGFkbWVsbGF6dW5pZ2FAZ21haWwuY29tKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MjQgVGQgKFRlbGVmb25vOiArNTY0NTEyMjU2MTMxMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBSb21hIDEyMywgQXJpY2EpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoYzEyMykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU4NCBUZCAoY2FyZ2Fkb3IgdGVsZWZvbm8gLSBjYXJnYWRvciB0ZWxlZm9ubykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMS4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkNi41MDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1ODQgVGQgKCQ3LjczNSkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTU2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU2NCBUZCAoMDEyNDUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NjQgVGQgKGN1YWRlcm5vcyB1bml2ZXJzaXRhcmlvcyAtIDdtbSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU2NCBUZCAoMjMuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NjQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDIuNTAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MjIgNTY0IFRkICgkNjguNDI1KSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzYwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzNjcgVGQgKFN1YnRvdGFsKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzY3IFRkICgkNjQuMDAwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzQwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzNDcgVGQgKERlc2N1ZW50bykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDM0NyBUZCAoLSAkMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDMyMCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzI3IFRkIChOZXRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzI3IFRkICgkNjQuMDAwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzAwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMDcgVGQgKElWQSBcKDE5JVwpKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzA3IFRkICgkMTIuMTYwKSBUaiBFVAowLjEyIDAuMzEgMC40NyByZyAzMzAgMjgwIDI0MiAyMiByZSBmCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDMzOCAyODggVGQgKFRvdGFsKSBUaiBFVApCVCAvRjEgOSBUZiAxIDEgMSByZyA1MDAgMjg4IFRkICgkNzYuMTYwKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkICgpIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAxOTAgVGQgKFRlcm1pbm9zIHkgY29uZGljaW9uZXMpIFRqIEVUCjAuMyAwLjM1IDAuNCBSRyAxIHcgNzAgNzggbSAyNjAgNzggbCBTCjAuMyAwLjM1IDAuNCBSRyAxIHcgMzUwIDc4IG0gNTQwIDc4IGwgUwpCVCAvRjEgOSBUZiAwIDAgMCByZyAxMzAgNjYgVGQgKHNvbGUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEzMCA1NCBUZCAoRWplY3V0aXZvIENvbWVyY2lhbCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDIwIDY2IFRkIChDbGllbnRlIFBydWViYSBjdWF0cm8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQxMCA1NCBUZCAoQWNlcHRhY2lvbiBjbGllbnRlKSBUaiBFVApCVCAvRjEgNyBUZiAwLjQgMC40NSAwLjUgcmcgMjEwIDM2IFRkIChEb2N1bWVudG8gZ2VuZXJhZG8gYXV0b21hdGljYW1lbnRlIHBvciBlbCBzaXN0ZW1hIGRlIGNvdGl6YWNpb25lcy4pIFRqIEVUCmVuZHN0cmVhbSBlbmRvYmoKeHJlZgowIDYKMDAwMDAwMDAwMCA2NTUzNSBmIAowMDAwMDAwMDA5IDAwMDAwIG4gCjAwMDAwMDAwNTggMDAwMDAgbiAKMDAwMDAwMDExNSAwMDAwMCBuIAowMDAwMDAwMjQxIDAwMDAwIG4gCjAwMDAwMDAzMTEgMDAwMDAgbiAKdHJhaWxlciA8PCAvU2l6ZSA2IC9Sb290IDEgMCBSID4+CnN0YXJ0eHJlZgozOTAwCiUlRU9G\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/c095525847379fe79af9f55ffb523aa1aba91ad80c3f93d66fa780fa6bd8f2e4\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/9\"}', 'enviado', '2026-04-11 13:41:24'),
(32, 'soledadmellazuniga@gmail.com', 'Cotización COT-073-000004 - Nombre Comercial Prueba dos', 'cotizacion_cliente_profesional', '{\"empresa\":\"Nombre Comercial Prueba dos\",\"cliente\":\"Cliente Prueba cuatro\",\"cliente_id\":9,\"numero\":\"COT-073-000004\",\"fecha_vencimiento\":\"2026-04-26\",\"total\":\"76.160,00\",\"remitente_correo\":\"soledadmellazuniga@gmail.com\",\"remitente_nombre\":\"Nombre Comercial Prueba dos\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Nombre Comercial Prueba dos<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Cliente Prueba cuatro<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-073-000004<\\/strong> por un total de <strong>$76.160,00<\\/strong>, con vigencia hasta el <strong>2026-04-26<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/c095525847379fe79af9f55ffb523aa1aba91ad80c3f93d66fa780fa6bd8f2e4\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/9\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/9<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-073-000004.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzUzNyA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKE5vbWJyZSBDb21lcmNpYWwgUHJ1ZWJhIGRvcykgVGogRVQKQlQgL0YxIDExIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQzMCA3NDggVGQgKENPVElaQUNJT04pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MzQgVGQgKE5cMjYwOiBDT1QtMDczLTAwMDAwNCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDcyMCBUZCAoRmVjaGE6IDIwMjYtMDQtMTEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MDYgVGQgKFZhbGlkZXo6IDIwMjYtMDQtMjYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcyNCBUZCAoUlVUOiAyNTEzMjE3OTUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcxMCBUZCAoUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY5NiBUZCAoVGVsZWZvbm86ICs1Njk2NTgyNzUzMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjgyIFRkIChDb3JyZW86IHNvbGVkYWRtZWxsYXp1bmlnYUBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IENsaWVudGUgUHJ1ZWJhIGN1YXRybykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiAzMy4zMzMuMzMzLTMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IENsaWVudGUgUHJ1ZWJhIGN1YXRybykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiBzb2xlZGFkbWVsbGF6dW5pZ2FAZ21haWwuY29tKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MjQgVGQgKFRlbGVmb25vOiArNTY0NTEyMjU2MTMxMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBSb21hIDEyMywgQXJpY2EpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoYzEyMykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU4NCBUZCAoY2FyZ2Fkb3IgdGVsZWZvbm8gLSBjYXJnYWRvciB0ZWxlZm9ubykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMS4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkNi41MDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1ODQgVGQgKCQ3LjczNSkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTU2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU2NCBUZCAoMDEyNDUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NjQgVGQgKGN1YWRlcm5vcyB1bml2ZXJzaXRhcmlvcyAtIDdtbSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU2NCBUZCAoMjMuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NjQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDIuNTAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MjIgNTY0IFRkICgkNjguNDI1KSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzYwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzNjcgVGQgKFN1YnRvdGFsKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzY3IFRkICgkNjQuMDAwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzQwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzNDcgVGQgKERlc2N1ZW50bykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDM0NyBUZCAoLSAkMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDMyMCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzI3IFRkIChOZXRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzI3IFRkICgkNjQuMDAwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzAwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMDcgVGQgKElWQSBcKDE5JVwpKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzA3IFRkICgkMTIuMTYwKSBUaiBFVAowLjEyIDAuMzEgMC40NyByZyAzMzAgMjgwIDI0MiAyMiByZSBmCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDMzOCAyODggVGQgKFRvdGFsKSBUaiBFVApCVCAvRjEgOSBUZiAxIDEgMSByZyA1MDAgMjg4IFRkICgkNzYuMTYwKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkICgpIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAxOTAgVGQgKFRlcm1pbm9zIHkgY29uZGljaW9uZXMpIFRqIEVUCjAuMyAwLjM1IDAuNCBSRyAxIHcgNzAgNzggbSAyNjAgNzggbCBTCjAuMyAwLjM1IDAuNCBSRyAxIHcgMzUwIDc4IG0gNTQwIDc4IGwgUwpCVCAvRjEgOSBUZiAwIDAgMCByZyAxMzAgNjYgVGQgKHNvbGUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEzMCA1NCBUZCAoRWplY3V0aXZvIENvbWVyY2lhbCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDIwIDY2IFRkIChDbGllbnRlIFBydWViYSBjdWF0cm8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQxMCA1NCBUZCAoQWNlcHRhY2lvbiBjbGllbnRlKSBUaiBFVApCVCAvRjEgNyBUZiAwLjQgMC40NSAwLjUgcmcgMjEwIDM2IFRkIChEb2N1bWVudG8gZ2VuZXJhZG8gYXV0b21hdGljYW1lbnRlIHBvciBlbCBzaXN0ZW1hIGRlIGNvdGl6YWNpb25lcy4pIFRqIEVUCmVuZHN0cmVhbSBlbmRvYmoKeHJlZgowIDYKMDAwMDAwMDAwMCA2NTUzNSBmIAowMDAwMDAwMDA5IDAwMDAwIG4gCjAwMDAwMDAwNTggMDAwMDAgbiAKMDAwMDAwMDExNSAwMDAwMCBuIAowMDAwMDAwMjQxIDAwMDAwIG4gCjAwMDAwMDAzMTEgMDAwMDAgbiAKdHJhaWxlciA8PCAvU2l6ZSA2IC9Sb290IDEgMCBSID4+CnN0YXJ0eHJlZgozOTAwCiUlRU9G\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/c095525847379fe79af9f55ffb523aa1aba91ad80c3f93d66fa780fa6bd8f2e4\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/9\"}', 'enviado', '2026-04-11 13:41:58'),
(33, 'soledadmellazuniga@gmail.com', 'Cotización COT-073-000004 - Nombre Comercial Prueba dos', 'cotizacion_cliente_profesional', '{\"empresa\":\"Nombre Comercial Prueba dos\",\"cliente\":\"Cliente Prueba cuatro\",\"cliente_id\":9,\"numero\":\"COT-073-000004\",\"fecha_vencimiento\":\"2026-04-26\",\"total\":\"76.160,00\",\"remitente_correo\":\"soledadmellazuniga@gmail.com\",\"remitente_nombre\":\"Nombre Comercial Prueba dos\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Nombre Comercial Prueba dos<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Cliente Prueba cuatro<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-073-000004<\\/strong> por un total de <strong>$76.160,00<\\/strong>, con vigencia hasta el <strong>2026-04-26<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/c095525847379fe79af9f55ffb523aa1aba91ad80c3f93d66fa780fa6bd8f2e4\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/9\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/9<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-073-000004.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzUzNyA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKE5vbWJyZSBDb21lcmNpYWwgUHJ1ZWJhIGRvcykgVGogRVQKQlQgL0YxIDExIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQzMCA3NDggVGQgKENPVElaQUNJT04pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MzQgVGQgKE5cMjYwOiBDT1QtMDczLTAwMDAwNCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDcyMCBUZCAoRmVjaGE6IDIwMjYtMDQtMTEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MDYgVGQgKFZhbGlkZXo6IDIwMjYtMDQtMjYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcyNCBUZCAoUlVUOiAyNTEzMjE3OTUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcxMCBUZCAoUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY5NiBUZCAoVGVsZWZvbm86ICs1Njk2NTgyNzUzMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjgyIFRkIChDb3JyZW86IHNvbGVkYWRtZWxsYXp1bmlnYUBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IENsaWVudGUgUHJ1ZWJhIGN1YXRybykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiAzMy4zMzMuMzMzLTMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IENsaWVudGUgUHJ1ZWJhIGN1YXRybykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiBzb2xlZGFkbWVsbGF6dW5pZ2FAZ21haWwuY29tKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MjQgVGQgKFRlbGVmb25vOiArNTY0NTEyMjU2MTMxMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBSb21hIDEyMywgQXJpY2EpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoYzEyMykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU4NCBUZCAoY2FyZ2Fkb3IgdGVsZWZvbm8gLSBjYXJnYWRvciB0ZWxlZm9ubykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoMS4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkNi41MDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1ODQgVGQgKCQ3LjczNSkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTU2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU2NCBUZCAoMDEyNDUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NjQgVGQgKGN1YWRlcm5vcyB1bml2ZXJzaXRhcmlvcyAtIDdtbSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU2NCBUZCAoMjMuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NjQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDIuNTAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MjIgNTY0IFRkICgkNjguNDI1KSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzYwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzNjcgVGQgKFN1YnRvdGFsKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzY3IFRkICgkNjQuMDAwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzQwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzNDcgVGQgKERlc2N1ZW50bykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDM0NyBUZCAoLSAkMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDMyMCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzI3IFRkIChOZXRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzI3IFRkICgkNjQuMDAwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzAwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMDcgVGQgKElWQSBcKDE5JVwpKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzA3IFRkICgkMTIuMTYwKSBUaiBFVAowLjEyIDAuMzEgMC40NyByZyAzMzAgMjgwIDI0MiAyMiByZSBmCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDMzOCAyODggVGQgKFRvdGFsKSBUaiBFVApCVCAvRjEgOSBUZiAxIDEgMSByZyA1MDAgMjg4IFRkICgkNzYuMTYwKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkICgpIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAxOTAgVGQgKFRlcm1pbm9zIHkgY29uZGljaW9uZXMpIFRqIEVUCjAuMyAwLjM1IDAuNCBSRyAxIHcgNzAgNzggbSAyNjAgNzggbCBTCjAuMyAwLjM1IDAuNCBSRyAxIHcgMzUwIDc4IG0gNTQwIDc4IGwgUwpCVCAvRjEgOSBUZiAwIDAgMCByZyAxMzAgNjYgVGQgKHNvbGUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEzMCA1NCBUZCAoRWplY3V0aXZvIENvbWVyY2lhbCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDIwIDY2IFRkIChDbGllbnRlIFBydWViYSBjdWF0cm8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQxMCA1NCBUZCAoQWNlcHRhY2lvbiBjbGllbnRlKSBUaiBFVApCVCAvRjEgNyBUZiAwLjQgMC40NSAwLjUgcmcgMjEwIDM2IFRkIChEb2N1bWVudG8gZ2VuZXJhZG8gYXV0b21hdGljYW1lbnRlIHBvciBlbCBzaXN0ZW1hIGRlIGNvdGl6YWNpb25lcy4pIFRqIEVUCmVuZHN0cmVhbSBlbmRvYmoKeHJlZgowIDYKMDAwMDAwMDAwMCA2NTUzNSBmIAowMDAwMDAwMDA5IDAwMDAwIG4gCjAwMDAwMDAwNTggMDAwMDAgbiAKMDAwMDAwMDExNSAwMDAwMCBuIAowMDAwMDAwMjQxIDAwMDAwIG4gCjAwMDAwMDAzMTEgMDAwMDAgbiAKdHJhaWxlciA8PCAvU2l6ZSA2IC9Sb290IDEgMCBSID4+CnN0YXJ0eHJlZgozOTAwCiUlRU9G\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/c095525847379fe79af9f55ffb523aa1aba91ad80c3f93d66fa780fa6bd8f2e4\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/9\"}', 'enviado', '2026-04-11 13:43:31'),
(34, 'soledadmellazuniga@gmail.com', 'Cotización COT-073-000005 - Nombre Comercial Prueba dos', 'cotizacion_cliente_profesional', '{\"empresa\":\"Nombre Comercial Prueba dos\",\"cliente\":\"Razon Social Prueba cinco\",\"cliente_id\":10,\"numero\":\"COT-073-000005\",\"fecha_vencimiento\":\"2026-04-26\",\"total\":\"156.366,00\",\"remitente_correo\":\"soledadmellazuniga@gmail.com\",\"remitente_nombre\":\"Nombre Comercial Prueba dos\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Nombre Comercial Prueba dos<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Razon Social Prueba cinco<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-073-000005<\\/strong> por un total de <strong>$156.366,00<\\/strong>, con vigencia hasta el <strong>2026-04-26<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/3b279446b8deb3f5bcdec97c6d1d2aa527e8f761ad8b6e6643f18aadb9203d4c\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/10\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/10<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-073-000005.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzU1NiA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKE5vbWJyZSBDb21lcmNpYWwgUHJ1ZWJhIGRvcykgVGogRVQKQlQgL0YxIDExIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQzMCA3NDggVGQgKENPVElaQUNJT04pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MzQgVGQgKE5cMjYwOiBDT1QtMDczLTAwMDAwNSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDcyMCBUZCAoRmVjaGE6IDIwMjYtMDQtMTEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MDYgVGQgKFZhbGlkZXo6IDIwMjYtMDQtMjYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcyNCBUZCAoUlVUOiAyNTEzMjE3OTUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcxMCBUZCAoUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY5NiBUZCAoVGVsZWZvbm86ICs1Njk2NTgyNzUzMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjgyIFRkIChDb3JyZW86IHNvbGVkYWRtZWxsYXp1bmlnYUBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IFJhem9uIFNvY2lhbCBQcnVlYmEgY2luY28pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDMwMCA2NTIgVGQgKFJVVDogMTAuMTAwLjEwMC0xKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MzggVGQgKENvbnRhY3RvOiBSYXpvbiBTb2NpYWwgUHJ1ZWJhIGNpbmNvKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyAzMDAgNjM4IFRkIChDb3JyZW86IHNvbGVkYWRtZWxsYXp1bmlnYUBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1NjQ1MTIyNTYxMzEzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyAzMDAgNjI0IFRkIChEaXJlY2Npb246IFJvbWEgMTIzLCBBcmljYSkgVGogRVQKMC4xMiAwLjMxIDAuNDcgcmcgNDAgNTk0IDUzMiAxOCByZSBmCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ0IDYwMCBUZCAoQ29kaWdvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAxMDAgNjAwIFRkIChEZXNjcmlwY2lvbikgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMzQ1IDYwMCBUZCAoQ2FudC4pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM5MCA2MDAgVGQgKFVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgNDUwIDYwMCBUZCAoUC4gVW5pdGFyaW8pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDUyMCA2MDAgVGQgKFRvdGFsKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyA0MCA1NzYgNTMyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDQgNTg0IFRkICgxMjQpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKHJvcGEgZGUgbmnxbyAtIGJ1em8gZGUgbmnxbykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoNi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkMTUuOTAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MjIgNTg0IFRkICgkMTEzLjUyNikgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTU2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU2NCBUZCAoMjMyMSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU2NCBUZCAocGx1bW9uIGRlIGNhbWEgMiBwbGF6YXMgLSBwbHVtb24gY2FtYSAxIDEvMikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU2NCBUZCAoMi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU2NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTY0IFRkICgkMTguMDAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MjIgNTY0IFRkICgkNDIuODQwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzYwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzNjcgVGQgKFN1YnRvdGFsKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzY3IFRkICgkMTMxLjQwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM0MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzQ3IFRkIChEZXNjdWVudG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNDcgVGQgKC0gJDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMyNyBUZCAoTmV0bykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMyNyBUZCAoJDEzMS40MDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMwNyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMDcgVGQgKCQyNC45NjYpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDMzMCAyODAgMjQyIDIyIHJlIGYKQlQgL0YxIDkgVGYgMSAxIDEgcmcgMzM4IDI4OCBUZCAoVG90YWwpIFRqIEVUCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDUwMCAyODggVGQgKCQxNTYuMzY2KSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkICgpIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAxOTAgVGQgKFRlcm1pbm9zIHkgY29uZGljaW9uZXMpIFRqIEVUCjAuMyAwLjM1IDAuNCBSRyAxIHcgNzAgNzggbSAyNjAgNzggbCBTCjAuMyAwLjM1IDAuNCBSRyAxIHcgMzUwIDc4IG0gNTQwIDc4IGwgUwpCVCAvRjEgOSBUZiAwIDAgMCByZyAxMzAgNjYgVGQgKHNvbGUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEzMCA1NCBUZCAoRWplY3V0aXZvIENvbWVyY2lhbCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDIwIDY2IFRkIChSYXpvbiBTb2NpYWwgUHJ1ZWJhIGNpbmNvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKMzkxOQolJUVPRg==\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/3b279446b8deb3f5bcdec97c6d1d2aa527e8f761ad8b6e6643f18aadb9203d4c\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/10\"}', 'enviado', '2026-04-11 14:34:56'),
(35, 'soledadmellazuniga@gmail.com', 'Cotización COT-073-000005 - Nombre Comercial Prueba dos', 'cotizacion_cliente_profesional', '{\"empresa\":\"Nombre Comercial Prueba dos\",\"cliente\":\"Razon Social Prueba cinco\",\"cliente_id\":10,\"numero\":\"COT-073-000005\",\"fecha_vencimiento\":\"2026-04-26\",\"total\":\"156.366,00\",\"remitente_correo\":\"soledadmellazuniga@gmail.com\",\"remitente_nombre\":\"Nombre Comercial Prueba dos\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Nombre Comercial Prueba dos<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Razon Social Prueba cinco<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-073-000005<\\/strong> por un total de <strong>$156.366,00<\\/strong>, con vigencia hasta el <strong>2026-04-26<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/3b279446b8deb3f5bcdec97c6d1d2aa527e8f761ad8b6e6643f18aadb9203d4c\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/10\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/10<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-073-000005.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzU1NiA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKE5vbWJyZSBDb21lcmNpYWwgUHJ1ZWJhIGRvcykgVGogRVQKQlQgL0YxIDExIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQzMCA3NDggVGQgKENPVElaQUNJT04pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MzQgVGQgKE5cMjYwOiBDT1QtMDczLTAwMDAwNSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDcyMCBUZCAoRmVjaGE6IDIwMjYtMDQtMTEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MDYgVGQgKFZhbGlkZXo6IDIwMjYtMDQtMjYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcyNCBUZCAoUlVUOiAyNTEzMjE3OTUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcxMCBUZCAoUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY5NiBUZCAoVGVsZWZvbm86ICs1Njk2NTgyNzUzMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjgyIFRkIChDb3JyZW86IHNvbGVkYWRtZWxsYXp1bmlnYUBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IFJhem9uIFNvY2lhbCBQcnVlYmEgY2luY28pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDMwMCA2NTIgVGQgKFJVVDogMTAuMTAwLjEwMC0xKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MzggVGQgKENvbnRhY3RvOiBSYXpvbiBTb2NpYWwgUHJ1ZWJhIGNpbmNvKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyAzMDAgNjM4IFRkIChDb3JyZW86IHNvbGVkYWRtZWxsYXp1bmlnYUBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1NjQ1MTIyNTYxMzEzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyAzMDAgNjI0IFRkIChEaXJlY2Npb246IFJvbWEgMTIzLCBBcmljYSkgVGogRVQKMC4xMiAwLjMxIDAuNDcgcmcgNDAgNTk0IDUzMiAxOCByZSBmCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ0IDYwMCBUZCAoQ29kaWdvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAxMDAgNjAwIFRkIChEZXNjcmlwY2lvbikgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMzQ1IDYwMCBUZCAoQ2FudC4pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM5MCA2MDAgVGQgKFVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgNDUwIDYwMCBUZCAoUC4gVW5pdGFyaW8pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDUyMCA2MDAgVGQgKFRvdGFsKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyA0MCA1NzYgNTMyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDQgNTg0IFRkICgxMjQpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKHJvcGEgZGUgbmnxbyAtIGJ1em8gZGUgbmnxbykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoNi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkMTUuOTAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MjIgNTg0IFRkICgkMTEzLjUyNikgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTU2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU2NCBUZCAoMjMyMSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU2NCBUZCAocGx1bW9uIGRlIGNhbWEgMiBwbGF6YXMgLSBwbHVtb24gY2FtYSAxIDEvMikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU2NCBUZCAoMi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU2NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTY0IFRkICgkMTguMDAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MjIgNTY0IFRkICgkNDIuODQwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzYwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzNjcgVGQgKFN1YnRvdGFsKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzY3IFRkICgkMTMxLjQwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM0MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzQ3IFRkIChEZXNjdWVudG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNDcgVGQgKC0gJDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMyNyBUZCAoTmV0bykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMyNyBUZCAoJDEzMS40MDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMwNyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMDcgVGQgKCQyNC45NjYpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDMzMCAyODAgMjQyIDIyIHJlIGYKQlQgL0YxIDkgVGYgMSAxIDEgcmcgMzM4IDI4OCBUZCAoVG90YWwpIFRqIEVUCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDUwMCAyODggVGQgKCQxNTYuMzY2KSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkICgpIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAxOTAgVGQgKFRlcm1pbm9zIHkgY29uZGljaW9uZXMpIFRqIEVUCjAuMyAwLjM1IDAuNCBSRyAxIHcgNzAgNzggbSAyNjAgNzggbCBTCjAuMyAwLjM1IDAuNCBSRyAxIHcgMzUwIDc4IG0gNTQwIDc4IGwgUwpCVCAvRjEgOSBUZiAwIDAgMCByZyAxMzAgNjYgVGQgKHNvbGUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEzMCA1NCBUZCAoRWplY3V0aXZvIENvbWVyY2lhbCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDIwIDY2IFRkIChSYXpvbiBTb2NpYWwgUHJ1ZWJhIGNpbmNvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKMzkxOQolJUVPRg==\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/3b279446b8deb3f5bcdec97c6d1d2aa527e8f761ad8b6e6643f18aadb9203d4c\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/10\"}', 'enviado', '2026-04-11 14:35:16'),
(36, 'soledadmellazuniga@gmail.com', 'Cotización COT-073-000006 - Nombre Comercial Prueba dos', 'cotizacion_cliente_profesional', '{\"empresa\":\"Nombre Comercial Prueba dos\",\"cliente\":\"Razon Social Prueba cinco\",\"cliente_id\":10,\"numero\":\"COT-073-000006\",\"fecha_vencimiento\":\"2026-04-26\",\"total\":\"134.946,00\",\"remitente_correo\":\"soledadmellazuniga@gmail.com\",\"remitente_nombre\":\"Nombre Comercial Prueba dos\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Nombre Comercial Prueba dos<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Razon Social Prueba cinco<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-073-000006<\\/strong> por un total de <strong>$134.946,00<\\/strong>, con vigencia hasta el <strong>2026-04-26<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/690ce7f200db3cf3864006599c4ef8d4d7cc1c3fd9706c2c75d74f92c66aec38\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/11\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/11<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-073-000006.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzU0NCA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKE5vbWJyZSBDb21lcmNpYWwgUHJ1ZWJhIGRvcykgVGogRVQKQlQgL0YxIDExIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQzMCA3NDggVGQgKENPVElaQUNJT04pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MzQgVGQgKE5cMjYwOiBDT1QtMDczLTAwMDAwNikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDcyMCBUZCAoRmVjaGE6IDIwMjYtMDQtMTEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MDYgVGQgKFZhbGlkZXo6IDIwMjYtMDQtMjYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcyNCBUZCAoUlVUOiAyNTEzMjE3OTUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcxMCBUZCAoUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY5NiBUZCAoVGVsZWZvbm86ICs1Njk2NTgyNzUzMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjgyIFRkIChDb3JyZW86IHNvbGVkYWRtZWxsYXp1bmlnYUBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IFJhem9uIFNvY2lhbCBQcnVlYmEgY2luY28pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDMwMCA2NTIgVGQgKFJVVDogMTAuMTAwLjEwMC0xKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MzggVGQgKENvbnRhY3RvOiBSYXpvbiBTb2NpYWwgUHJ1ZWJhIGNpbmNvKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyAzMDAgNjM4IFRkIChDb3JyZW86IHNvbGVkYWRtZWxsYXp1bmlnYUBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1NjQ1MTIyNTYxMzEzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyAzMDAgNjI0IFRkIChEaXJlY2Npb246IFJvbWEgMTIzLCBBcmljYSkgVGogRVQKMC4xMiAwLjMxIDAuNDcgcmcgNDAgNTk0IDUzMiAxOCByZSBmCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ0IDYwMCBUZCAoQ29kaWdvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAxMDAgNjAwIFRkIChEZXNjcmlwY2lvbikgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMzQ1IDYwMCBUZCAoQ2FudC4pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM5MCA2MDAgVGQgKFVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgNDUwIDYwMCBUZCAoUC4gVW5pdGFyaW8pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDUyMCA2MDAgVGQgKFRvdGFsKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyA0MCA1NzYgNTMyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDQgNTg0IFRkICgxMjQpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKHJvcGEgZGUgbmnxbyAtIGJ1em8gZGUgbmnxbykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU4NCBUZCAoNi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkMTUuOTAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MjIgNTg0IFRkICgkMTEzLjUyNikgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTU2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU2NCBUZCAoMDIzKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMDAgNTY0IFRkIChzYWJhbmFzIDEgMS8yIC0gc2FiYW5hcyBkZSAxIDEvMikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU2NCBUZCAoMS4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU2NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTY0IFRkICgkMTguMDAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MjIgNTY0IFRkICgkMjEuNDIwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzYwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzNjcgVGQgKFN1YnRvdGFsKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzY3IFRkICgkMTEzLjQwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM0MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzQ3IFRkIChEZXNjdWVudG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNDcgVGQgKC0gJDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMyNyBUZCAoTmV0bykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMyNyBUZCAoJDExMy40MDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMwNyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMDcgVGQgKCQyMS41NDYpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDMzMCAyODAgMjQyIDIyIHJlIGYKQlQgL0YxIDkgVGYgMSAxIDEgcmcgMzM4IDI4OCBUZCAoVG90YWwpIFRqIEVUCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDUwMCAyODggVGQgKCQxMzQuOTQ2KSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkICgpIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAxOTAgVGQgKFRlcm1pbm9zIHkgY29uZGljaW9uZXMpIFRqIEVUCjAuMyAwLjM1IDAuNCBSRyAxIHcgNzAgNzggbSAyNjAgNzggbCBTCjAuMyAwLjM1IDAuNCBSRyAxIHcgMzUwIDc4IG0gNTQwIDc4IGwgUwpCVCAvRjEgOSBUZiAwIDAgMCByZyAxMzAgNjYgVGQgKHNvbGUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEzMCA1NCBUZCAoRWplY3V0aXZvIENvbWVyY2lhbCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDIwIDY2IFRkIChSYXpvbiBTb2NpYWwgUHJ1ZWJhIGNpbmNvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKMzkwNwolJUVPRg==\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/690ce7f200db3cf3864006599c4ef8d4d7cc1c3fd9706c2c75d74f92c66aec38\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/11\"}', 'enviado', '2026-04-11 14:53:55');
INSERT INTO `logs_correos` (`id`, `destinatario`, `asunto`, `plantilla`, `payload`, `estado`, `fecha_creacion`) VALUES
(37, 'cliente@pruebaocho.cl', 'Cotización COT-074-000001 - Nombre comercial Prueba siete', 'cotizacion_cliente_profesional', '{\"empresa\":\"Nombre comercial Prueba siete\",\"cliente\":\"Razon Social  cliente prueba ocho\",\"cliente_id\":12,\"numero\":\"COT-074-000001\",\"fecha_vencimiento\":\"2026-04-26\",\"total\":\"218.960,00\",\"remitente_correo\":\"solcyta_240789@hotmail.com\",\"remitente_nombre\":\"Nombre comercial Prueba siete\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Nombre comercial Prueba siete<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Razon Social  cliente prueba ocho<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-074-000001<\\/strong> por un total de <strong>$218.960,00<\\/strong>, con vigencia hasta el <strong>2026-04-26<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/1ce54fc2e357c817e2e7a919682318000a03746f3a5a008fdf36cc6f5134f877\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/12\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/12<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-074-000001.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzk3MyA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKE5vbWJyZSBjb21lcmNpYWwgUHJ1ZWJhIHNpZXRlKSBUaiBFVApCVCAvRjEgMTEgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDMwIDc0OCBUZCAoQ09USVpBQ0lPTikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDczNCBUZCAoTlwyNjA6IENPVC0wNzQtMDAwMDAxKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzIwIFRkIChGZWNoYTogMjAyNi0wNC0xMSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDcwNiBUZCAoVmFsaWRlejogMjAyNi0wNC0yNikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzI0IFRkIChSVVQ6IDExLjExMS4xMTEtMSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzEwIFRkIChQYXJtYSAxMzEwLCBMb3MgQW5nZWxlcykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjk2IFRkIChUZWxlZm9ubzogKzU2OTY1ODI3NTMzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2ODIgVGQgKENvcnJlbzogc29sY3l0YV8yNDA3ODlAaG90bWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IFJhem9uIFNvY2lhbCAgY2xpZW50ZSBwcnVlYmEgb2NobykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiA2Ni42NjYuNjY2LTYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IFJhem9uIFNvY2lhbCAgY2xpZW50ZSBwcnVlYmEgb2NobykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiBjbGllbnRlQHBydWViYW9jaG8uY2wpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYyNCBUZCAoVGVsZWZvbm86ICs1Njk2NTgyNzUzMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYyNCBUZCAoRGlyZWNjaW9uOiBQYXJtYSAxMzEwLCBMb3MgQW5nZWxlcykgVGogRVQKMC4xMiAwLjMxIDAuNDcgcmcgNDAgNTk0IDUzMiAxOCByZSBmCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ0IDYwMCBUZCAoQ29kaWdvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAxMDAgNjAwIFRkIChEZXNjcmlwY2lvbikgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMzQ1IDYwMCBUZCAoQ2FudC4pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM5MCA2MDAgVGQgKFVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgNDUwIDYwMCBUZCAoUC4gVW5pdGFyaW8pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDUyMCA2MDAgVGQgKFRvdGFsKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyA0MCA1NzYgNTMyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDQgNTg0IFRkICgwMjU4KSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMDAgNTg0IFRkIChMYXBpY2VzIGRlIDEyIGNvbG9yZXMgYXJ0ZWwgLSBsYXBpY2VzIGRlIGNvbG9yZXMgaW50ZW5zb3MpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1ODQgVGQgKDU1LjAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAzOTIgNTg0IFRkICh1bmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ1MiA1ODQgVGQgKCQyLjYwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU4NCBUZCAoJDE3MC4xNzApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDQwIDU1NiA1MzIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA0NCA1NjQgVGQgKDQ3NSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU2NCBUZCAobGFwaXogZ3JhZml0byBhcnRlbCAtIGxhcGljZXMgZ3JhZml0byBhcnRlbCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU2NCBUZCAoMzAuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NjQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDMwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU2NCBUZCAoJDEwLjcxMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTM2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU0NCBUZCAoMDU0NCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU0NCBUZCAobGFwaXogcGFzdGEgIGJpYyAtIGxhcGljZXMgZGUgcGFzdGEgY29sb3IgYXp1bCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU0NCBUZCAoODAuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NDQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU0NCBUZCAoJDQwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU0NCBUZCAoJDM4LjA4MCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM2MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzY3IFRkIChTdWJ0b3RhbCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDM2NyBUZCAoJDE4NC4wMDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM0NyBUZCAoRGVzY3VlbnRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzQ3IFRkICgtICQwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzIwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMjcgVGQgKE5ldG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMjcgVGQgKCQxODQuMDAwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzAwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMDcgVGQgKElWQSBcKDE5JVwpKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzA3IFRkICgkMzQuOTYwKSBUaiBFVAowLjEyIDAuMzEgMC40NyByZyAzMzAgMjgwIDI0MiAyMiByZSBmCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDMzOCAyODggVGQgKFRvdGFsKSBUaiBFVApCVCAvRjEgOSBUZiAxIDEgMSByZyA1MDAgMjg4IFRkICgkMjE4Ljk2MCkgVGogRVQKQlQgL0YxIDEwIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQwIDI1OCBUZCAoT2JzZXJ2YWNpb25lcykgVGogRVQKMC45NyAwLjk4IDAuOTkgcmcgNDAgMjEwIDUzMiA0MCByZSBmCjAuMTIgMC4zMSAwLjQ3IFJHIDIgdyA0MCAyMTAgbSA0MCAyNTAgbCBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwIDIzNiBUZCAoKSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMTkwIFRkIChUZXJtaW5vcyB5IGNvbmRpY2lvbmVzKSBUaiBFVAowLjMgMC4zNSAwLjQgUkcgMSB3IDcwIDc4IG0gMjYwIDc4IGwgUwowLjMgMC4zNSAwLjQgUkcgMSB3IDM1MCA3OCBtIDU0MCA3OCBsIFMKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMTMwIDY2IFRkIChzb2xlZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMzAgNTQgVGQgKEVqZWN1dGl2byBDb21lcmNpYWwpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQyMCA2NiBUZCAoUmF6b24gU29jaWFsICBjbGllbnRlIHBydWViYSBvY2hvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKNDMzNgolJUVPRg==\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/1ce54fc2e357c817e2e7a919682318000a03746f3a5a008fdf36cc6f5134f877\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/12\"}', 'enviado', '2026-04-11 19:41:42'),
(38, 'soledadmellazuniga@gmail.com', 'Cotización COT-074-000001 - Nombre comercial Prueba siete', 'cotizacion_cliente_profesional', '{\"empresa\":\"Nombre comercial Prueba siete\",\"cliente\":\"Razon Social  cliente prueba ocho\",\"cliente_id\":12,\"numero\":\"COT-074-000001\",\"fecha_vencimiento\":\"2026-04-26\",\"total\":\"218.960,00\",\"remitente_correo\":\"solcyta_240789@hotmail.com\",\"remitente_nombre\":\"Nombre comercial Prueba siete\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Nombre comercial Prueba siete<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Razon Social  cliente prueba ocho<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-074-000001<\\/strong> por un total de <strong>$218.960,00<\\/strong>, con vigencia hasta el <strong>2026-04-26<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/1ce54fc2e357c817e2e7a919682318000a03746f3a5a008fdf36cc6f5134f877\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/12\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/12<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-074-000001.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzk4MCA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKE5vbWJyZSBjb21lcmNpYWwgUHJ1ZWJhIHNpZXRlKSBUaiBFVApCVCAvRjEgMTEgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDMwIDc0OCBUZCAoQ09USVpBQ0lPTikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDczNCBUZCAoTlwyNjA6IENPVC0wNzQtMDAwMDAxKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzIwIFRkIChGZWNoYTogMjAyNi0wNC0xMSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDcwNiBUZCAoVmFsaWRlejogMjAyNi0wNC0yNikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzI0IFRkIChSVVQ6IDExLjExMS4xMTEtMSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzEwIFRkIChQYXJtYSAxMzEwLCBMb3MgQW5nZWxlcykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjk2IFRkIChUZWxlZm9ubzogKzU2OTY1ODI3NTMzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2ODIgVGQgKENvcnJlbzogc29sY3l0YV8yNDA3ODlAaG90bWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IFJhem9uIFNvY2lhbCAgY2xpZW50ZSBwcnVlYmEgb2NobykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDY1MiBUZCAoUlVUOiA2Ni42NjYuNjY2LTYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDYzOCBUZCAoQ29udGFjdG86IFJhem9uIFNvY2lhbCAgY2xpZW50ZSBwcnVlYmEgb2NobykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiBzb2xlZGFkbWVsbGF6dW5pZ2FAZ21haWwuY29tKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MjQgVGQgKFRlbGVmb25vOiArNTY5NjU4Mjc1MzMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDMwMCA2MjQgVGQgKERpcmVjY2lvbjogUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoMDI1OCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU4NCBUZCAoTGFwaWNlcyBkZSAxMiBjb2xvcmVzIGFydGVsIC0gbGFwaWNlcyBkZSBjb2xvcmVzIGludGVuc29zKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAzNDggNTg0IFRkICg1NS4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU4NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTg0IFRkICgkMi42MDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1ODQgVGQgKCQxNzAuMTcwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyA0MCA1NTYgNTMyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDQgNTY0IFRkICg0NzUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NjQgVGQgKGxhcGl6IGdyYWZpdG8gYXJ0ZWwgLSBsYXBpY2VzIGdyYWZpdG8gYXJ0ZWwpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1NjQgVGQgKDMwLjAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAzOTIgNTY0IFRkICh1bmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ1MiA1NjQgVGQgKCQzMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1NjQgVGQgKCQxMC43MTApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDQwIDUzNiA1MzIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA0NCA1NDQgVGQgKDA1NDQpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1NDQgVGQgKGxhcGl6IHBhc3RhICBiaWMgLSBsYXBpY2VzIGRlIHBhc3RhIGNvbG9yIGF6dWwpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1NDQgVGQgKDgwLjAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAzOTIgNTQ0IFRkICh1bmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ1MiA1NDQgVGQgKCQ0MDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1NDQgVGQgKCQzOC4wODApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM2NyBUZCAoU3VidG90YWwpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNjcgVGQgKCQxODQuMDAwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzQwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzNDcgVGQgKERlc2N1ZW50bykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDM0NyBUZCAoLSAkMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDMyMCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzI3IFRkIChOZXRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzI3IFRkICgkMTg0LjAwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDMwMCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzA3IFRkIChJVkEgXCgxOSVcKSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMwNyBUZCAoJDM0Ljk2MCkgVGogRVQKMC4xMiAwLjMxIDAuNDcgcmcgMzMwIDI4MCAyNDIgMjIgcmUgZgpCVCAvRjEgOSBUZiAxIDEgMSByZyAzMzggMjg4IFRkIChUb3RhbCkgVGogRVQKQlQgL0YxIDkgVGYgMSAxIDEgcmcgNTAwIDI4OCBUZCAoJDIxOC45NjApIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAyNTggVGQgKE9ic2VydmFjaW9uZXMpIFRqIEVUCjAuOTcgMC45OCAwLjk5IHJnIDQwIDIxMCA1MzIgNDAgcmUgZgowLjEyIDAuMzEgMC40NyBSRyAyIHcgNDAgMjEwIG0gNDAgMjUwIGwgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA1MCAyMzYgVGQgKCkgVGogRVQKQlQgL0YxIDEwIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQwIDE5MCBUZCAoVGVybWlub3MgeSBjb25kaWNpb25lcykgVGogRVQKMC4zIDAuMzUgMC40IFJHIDEgdyA3MCA3OCBtIDI2MCA3OCBsIFMKMC4zIDAuMzUgMC40IFJHIDEgdyAzNTAgNzggbSA1NDAgNzggbCBTCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDEzMCA2NiBUZCAoc29sZWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTMwIDU0IFRkIChFamVjdXRpdm8gQ29tZXJjaWFsKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MjAgNjYgVGQgKFJhem9uIFNvY2lhbCAgY2xpZW50ZSBwcnVlYmEgb2NobykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDEwIDU0IFRkIChBY2VwdGFjaW9uIGNsaWVudGUpIFRqIEVUCkJUIC9GMSA3IFRmIDAuNCAwLjQ1IDAuNSByZyAyMTAgMzYgVGQgKERvY3VtZW50byBnZW5lcmFkbyBhdXRvbWF0aWNhbWVudGUgcG9yIGVsIHNpc3RlbWEgZGUgY290aXphY2lvbmVzLikgVGogRVQKZW5kc3RyZWFtIGVuZG9iagp4cmVmCjAgNgowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAwMDAwMDkgMDAwMDAgbiAKMDAwMDAwMDA1OCAwMDAwMCBuIAowMDAwMDAwMTE1IDAwMDAwIG4gCjAwMDAwMDAyNDEgMDAwMDAgbiAKMDAwMDAwMDMxMSAwMDAwMCBuIAp0cmFpbGVyIDw8IC9TaXplIDYgL1Jvb3QgMSAwIFIgPj4Kc3RhcnR4cmVmCjQzNDMKJSVFT0Y=\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/1ce54fc2e357c817e2e7a919682318000a03746f3a5a008fdf36cc6f5134f877\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/12\"}', 'enviado', '2026-04-11 21:20:15'),
(39, 'soledadmellazuniga@gmail.com', 'Cotización COT-075-000002 - NOMBRE COMERCIAL PRUEBA QUINCE', 'cotizacion_cliente_profesional', '{\"empresa\":\"NOMBRE COMERCIAL PRUEBA QUINCE\",\"cliente\":\"CLIENTE QUINCE\",\"cliente_id\":14,\"numero\":\"COT-075-000002\",\"fecha_vencimiento\":\"2026-04-26\",\"total\":\"1.808.800,00\",\"remitente_correo\":\"vicente.isla13@gmail.com\",\"remitente_nombre\":\"NOMBRE COMERCIAL PRUEBA QUINCE\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">NOMBRE COMERCIAL PRUEBA QUINCE<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>CLIENTE QUINCE<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-075-000002<\\/strong> por un total de <strong>$1.808.800,00<\\/strong>, con vigencia hasta el <strong>2026-04-26<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/850ff8887d934bb6f75e0e8d53e5d7be7eef0b7773857f3d3b8244cca2618359\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/14\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/14<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-075-000002.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzU1OCA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKE5PTUJSRSBDT01FUkNJQUwgUFJVRUJBIFFVSU5DRSkgVGogRVQKQlQgL0YxIDExIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQzMCA3NDggVGQgKENPVElaQUNJT04pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MzQgVGQgKE5cMjYwOiBDT1QtMDc1LTAwMDAwMikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDcyMCBUZCAoRmVjaGE6IDIwMjYtMDQtMTEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MDYgVGQgKFZhbGlkZXo6IDIwMjYtMDQtMjYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcyNCBUZCAoUlVUOiA1NTU1NTU1LTUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcxMCBUZCAoUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY5NiBUZCAoVGVsZWZvbm86ICs1Njk2NTgyNzUzMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjgyIFRkIChDb3JyZW86IHZpY2VudGUuaXNsYTEzQGdtYWlsLmNvbSkgVGogRVQKQlQgL0YxIDEwIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQwIDY2OCBUZCAoRGF0b3MgZGVsIGNsaWVudGUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY1MiBUZCAoQ2xpZW50ZTogQ0xJRU5URSBRVUlOQ0UpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDMwMCA2NTIgVGQgKFJVVDogMTAuMTAwLjEwMC0xKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MzggVGQgKENvbnRhY3RvOiBDTElFTlRFIFFVSU5DRSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiBzb2xlZGFkbWVsbGF6dW5pZ2FAZ21haWwuY29tKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MjQgVGQgKFRlbGVmb25vOiArNTY5NjU4Mjc1MzMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDMwMCA2MjQgVGQgKERpcmVjY2lvbjogUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoNTI0NTYzNDUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKENFTFVMQVIgTU9UT1JPTEEgRzg1IC0gQ0VMVUxBUiBNT1RPIFBBTlRBTExBIDYuNyBHODUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1ODQgVGQgKDIuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1ODQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU4NCBUZCAoJDIxMC4wMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1ODQgVGQgKCQ0OTkuODAwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyA0MCA1NTYgNTMyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDQgNTY0IFRkICgyNTQ0NSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU2NCBUZCAoTk9URUJPT0sgLSBOT1RFQk9PSyBBQ0VSIDE0IikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU2NCBUZCAoMi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU2NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTY0IFRkICgkNTUwLjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU2NCBUZCAoJDEuMzA5LjAwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM2MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzY3IFRkIChTdWJ0b3RhbCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDM2NyBUZCAoJDEuNTIwLjAwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM0MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzQ3IFRkIChEZXNjdWVudG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNDcgVGQgKC0gJDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMyNyBUZCAoTmV0bykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMyNyBUZCAoJDEuNTIwLjAwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDMwMCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzA3IFRkIChJVkEgXCgxOSVcKSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMwNyBUZCAoJDI4OC44MDApIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDMzMCAyODAgMjQyIDIyIHJlIGYKQlQgL0YxIDkgVGYgMSAxIDEgcmcgMzM4IDI4OCBUZCAoVG90YWwpIFRqIEVUCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDUwMCAyODggVGQgKCQxLjgwOC44MDApIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAyNTggVGQgKE9ic2VydmFjaW9uZXMpIFRqIEVUCjAuOTcgMC45OCAwLjk5IHJnIDQwIDIxMCA1MzIgNDAgcmUgZgowLjEyIDAuMzEgMC40NyBSRyAyIHcgNDAgMjEwIG0gNDAgMjUwIGwgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA1MCAyMzYgVGQgKCkgVGogRVQKQlQgL0YxIDEwIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQwIDE5MCBUZCAoVGVybWlub3MgeSBjb25kaWNpb25lcykgVGogRVQKMC4zIDAuMzUgMC40IFJHIDEgdyA3MCA3OCBtIDI2MCA3OCBsIFMKMC4zIDAuMzUgMC40IFJHIDEgdyAzNTAgNzggbSA1NDAgNzggbCBTCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDEzMCA2NiBUZCAoU09MRSBNKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMzAgNTQgVGQgKEVqZWN1dGl2byBDb21lcmNpYWwpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQyMCA2NiBUZCAoQ0xJRU5URSBRVUlOQ0UpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQxMCA1NCBUZCAoQWNlcHRhY2lvbiBjbGllbnRlKSBUaiBFVApCVCAvRjEgNyBUZiAwLjQgMC40NSAwLjUgcmcgMjEwIDM2IFRkIChEb2N1bWVudG8gZ2VuZXJhZG8gYXV0b21hdGljYW1lbnRlIHBvciBlbCBzaXN0ZW1hIGRlIGNvdGl6YWNpb25lcy4pIFRqIEVUCmVuZHN0cmVhbSBlbmRvYmoKeHJlZgowIDYKMDAwMDAwMDAwMCA2NTUzNSBmIAowMDAwMDAwMDA5IDAwMDAwIG4gCjAwMDAwMDAwNTggMDAwMDAgbiAKMDAwMDAwMDExNSAwMDAwMCBuIAowMDAwMDAwMjQxIDAwMDAwIG4gCjAwMDAwMDAzMTEgMDAwMDAgbiAKdHJhaWxlciA8PCAvU2l6ZSA2IC9Sb290IDEgMCBSID4+CnN0YXJ0eHJlZgozOTIxCiUlRU9G\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/850ff8887d934bb6f75e0e8d53e5d7be7eef0b7773857f3d3b8244cca2618359\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/14\"}', 'enviado', '2026-04-11 22:43:24'),
(40, 'soledadmellazuniga@gmail.com', 'Cotización COT-075-000001 - NOMBRE COMERCIAL PRUEBA QUINCE', 'cotizacion_cliente_profesional', '{\"empresa\":\"NOMBRE COMERCIAL PRUEBA QUINCE\",\"cliente\":\"CLIENTE QUINCE\",\"cliente_id\":14,\"numero\":\"COT-075-000001\",\"fecha_vencimiento\":\"2026-04-26\",\"total\":\"2.058.700,00\",\"remitente_correo\":\"vicente.isla13@gmail.com\",\"remitente_nombre\":\"NOMBRE COMERCIAL PRUEBA QUINCE\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">NOMBRE COMERCIAL PRUEBA QUINCE<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>CLIENTE QUINCE<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-075-000001<\\/strong> por un total de <strong>$2.058.700,00<\\/strong>, con vigencia hasta el <strong>2026-04-26<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/7c330331d76f7db61347d5cd8b0351fdd69ecf37f83060f77e3b11f7ad6d97a4\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/13\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/13<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-075-000001.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggMzU1OCA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKE5PTUJSRSBDT01FUkNJQUwgUFJVRUJBIFFVSU5DRSkgVGogRVQKQlQgL0YxIDExIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQzMCA3NDggVGQgKENPVElaQUNJT04pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MzQgVGQgKE5cMjYwOiBDT1QtMDc1LTAwMDAwMSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDMwIDcyMCBUZCAoRmVjaGE6IDIwMjYtMDQtMTEpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MDYgVGQgKFZhbGlkZXo6IDIwMjYtMDQtMjYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcyNCBUZCAoUlVUOiA1NTU1NTU1LTUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDcxMCBUZCAoUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY5NiBUZCAoVGVsZWZvbm86ICs1Njk2NTgyNzUzMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjgyIFRkIChDb3JyZW86IHZpY2VudGUuaXNsYTEzQGdtYWlsLmNvbSkgVGogRVQKQlQgL0YxIDEwIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQwIDY2OCBUZCAoRGF0b3MgZGVsIGNsaWVudGUpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY1MiBUZCAoQ2xpZW50ZTogQ0xJRU5URSBRVUlOQ0UpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDMwMCA2NTIgVGQgKFJVVDogMTAuMTAwLjEwMC0xKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MzggVGQgKENvbnRhY3RvOiBDTElFTlRFIFFVSU5DRSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgMzAwIDYzOCBUZCAoQ29ycmVvOiBzb2xlZGFkbWVsbGF6dW5pZ2FAZ21haWwuY29tKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MjQgVGQgKFRlbGVmb25vOiArNTY5NjU4Mjc1MzMpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDMwMCA2MjQgVGQgKERpcmVjY2lvbjogUGFybWEgMTMxMCwgTG9zIEFuZ2VsZXMpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoNTI0NTYzNDUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKENFTFVMQVIgTU9UT1JPTEEgRzg1IC0gQ0VMVUxBUiBNT1RPIFBBTlRBTExBIDYuNyBHODUpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1ODQgVGQgKDMuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1ODQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU4NCBUZCAoJDIxMC4wMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1ODQgVGQgKCQ3NDkuNzAwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyA0MCA1NTYgNTMyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDQgNTY0IFRkICgyNTQ0NSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU2NCBUZCAoTk9URUJPT0sgLSBOT1RFQk9PSyBBQ0VSIDE0IikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDU2NCBUZCAoMi4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU2NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTY0IFRkICgkNTUwLjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU2NCBUZCAoJDEuMzA5LjAwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM2MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzY3IFRkIChTdWJ0b3RhbCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDM2NyBUZCAoJDEuNzMwLjAwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDM0MCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzQ3IFRkIChEZXNjdWVudG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNDcgVGQgKC0gJDApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzMjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDMyNyBUZCAoTmV0bykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMyNyBUZCAoJDEuNzMwLjAwMCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgMzMwIDMwMCAyNDIgMjAgcmUgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyAzMzggMzA3IFRkIChJVkEgXCgxOSVcKSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMwNyBUZCAoJDMyOC43MDApIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDMzMCAyODAgMjQyIDIyIHJlIGYKQlQgL0YxIDkgVGYgMSAxIDEgcmcgMzM4IDI4OCBUZCAoVG90YWwpIFRqIEVUCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDUwMCAyODggVGQgKCQyLjA1OC43MDApIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAyNTggVGQgKE9ic2VydmFjaW9uZXMpIFRqIEVUCjAuOTcgMC45OCAwLjk5IHJnIDQwIDIxMCA1MzIgNDAgcmUgZgowLjEyIDAuMzEgMC40NyBSRyAyIHcgNDAgMjEwIG0gNDAgMjUwIGwgUwpCVCAvRjEgOCBUZiAwIDAgMCByZyA1MCAyMzYgVGQgKCkgVGogRVQKQlQgL0YxIDEwIFRmIDAuMTIgMC4zMSAwLjQ3IHJnIDQwIDE5MCBUZCAoVGVybWlub3MgeSBjb25kaWNpb25lcykgVGogRVQKMC4zIDAuMzUgMC40IFJHIDEgdyA3MCA3OCBtIDI2MCA3OCBsIFMKMC4zIDAuMzUgMC40IFJHIDEgdyAzNTAgNzggbSA1NDAgNzggbCBTCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDEzMCA2NiBUZCAoU09MRSBNKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAxMzAgNTQgVGQgKEVqZWN1dGl2byBDb21lcmNpYWwpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQyMCA2NiBUZCAoQ0xJRU5URSBRVUlOQ0UpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQxMCA1NCBUZCAoQWNlcHRhY2lvbiBjbGllbnRlKSBUaiBFVApCVCAvRjEgNyBUZiAwLjQgMC40NSAwLjUgcmcgMjEwIDM2IFRkIChEb2N1bWVudG8gZ2VuZXJhZG8gYXV0b21hdGljYW1lbnRlIHBvciBlbCBzaXN0ZW1hIGRlIGNvdGl6YWNpb25lcy4pIFRqIEVUCmVuZHN0cmVhbSBlbmRvYmoKeHJlZgowIDYKMDAwMDAwMDAwMCA2NTUzNSBmIAowMDAwMDAwMDA5IDAwMDAwIG4gCjAwMDAwMDAwNTggMDAwMDAgbiAKMDAwMDAwMDExNSAwMDAwMCBuIAowMDAwMDAwMjQxIDAwMDAwIG4gCjAwMDAwMDAzMTEgMDAwMDAgbiAKdHJhaWxlciA8PCAvU2l6ZSA2IC9Sb290IDEgMCBSID4+CnN0YXJ0eHJlZgozOTIxCiUlRU9G\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/7c330331d76f7db61347d5cd8b0351fdd69ecf37f83060f77e3b11f7ad6d97a4\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/13\"}', 'enviado', '2026-04-11 22:50:08'),
(41, 'javieraagonzalezmoeller@gmail.com', 'Cotización COT-069-000006 - Empresa estudio SPA', 'cotizacion_cliente_profesional', '{\"empresa\":\"Empresa estudio SPA\",\"cliente\":\"Universidad Tecnológica de la Frontera S.A.\",\"cliente_id\":15,\"numero\":\"COT-069-000006\",\"fecha_vencimiento\":\"2026-04-13\",\"total\":\"10.362.817,50\",\"remitente_correo\":\"vextracl@gmail.com\",\"remitente_nombre\":\"Empresa estudio SPA\",\"mensaje_html\":\"<div style=\\\"font-family:Arial,Helvetica,sans-serif;background:#f5f7fb;padding:24px;color:#111827;\\\">\\n  <div style=\\\"max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\">\\n    <div style=\\\"background:#0f3d77;color:#ffffff;padding:20px 24px;\\\">\\n      <h2 style=\\\"margin:0;font-size:20px;\\\">Empresa estudio SPA<\\/h2>\\n      <p style=\\\"margin:6px 0 0;font-size:13px;opacity:.9;\\\">Envío automático de cotización<\\/p>\\n    <\\/div>\\n    <div style=\\\"padding:24px;\\\">\\n      <p style=\\\"margin:0 0 14px;\\\">Hola <strong>Universidad Tecnológica de la Frontera S.A.<\\/strong>,<\\/p>\\n      <p style=\\\"margin:0 0 14px;line-height:1.5;\\\">Adjuntamos la cotización <strong>COT-069-000006<\\/strong> por un total de <strong>$10.362.817,50<\\/strong>, con vigencia hasta el <strong>2026-04-13<\\/strong>.<\\/p>\\n      <p style=\\\"margin:0 0 20px;line-height:1.5;\\\">Puedes revisarla en línea y registrar tu decisión desde el siguiente botón:<\\/p>\\n      <p style=\\\"margin:0 0 18px;\\\">\\n        <a href=\\\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/619ca47311e13911eb364626bd8a1bb969f3802d4bde28fa0657aa9496eb52b0\\\" style=\\\"display:inline-block;background:#0f3d77;color:#ffffff;text-decoration:none;padding:12px 18px;border-radius:8px;font-weight:600;\\\">Ver, aceptar o rechazar cotización<\\/a>\\n      <\\/p>\\n      <p style=\\\"margin:0 0 8px;font-size:13px;color:#4b5563;\\\">También puedes descargar el PDF directamente:<\\/p>\\n      <p style=\\\"margin:0 0 20px;font-size:13px;\\\"><a href=\\\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/15\\\" style=\\\"color:#0f3d77;\\\">https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/15<\\/a><\\/p>\\n      <p style=\\\"margin:0;font-size:12px;color:#6b7280;\\\">Este correo fue generado automáticamente por el sistema de cotizaciones.<\\/p>\\n    <\\/div>\\n  <\\/div>\\n<\\/div>\",\"adjuntos\":[{\"nombre\":\"Cotizacion-COT-069-000006.pdf\",\"mime\":\"application\\/pdf\",\"contenido_base64\":\"JVBERi0xLjQKMSAwIG9iaiA8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4gZW5kb2JqCjIgMCBvYmogPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4gZW5kb2JqCjMgMCBvYmogPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA2MTIgNzkyXSAvUmVzb3VyY2VzIDw8IC9Gb250IDw8IC9GMSA0IDAgUiA+PiA+PiAvQ29udGVudHMgNSAwIFIgPj4gZW5kb2JqCjQgMCBvYmogPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+IGVuZG9iago1IDAgb2JqIDw8IC9MZW5ndGggNDgyNSA+PiBzdHJlYW0KMC45NSAwLjk2IDAuOTggcmcgMCAwIDYxMiA3OTIgcmUgZgoxIDEgMSByZyAyNiAyNiA1NjAgNzQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDI2IDY5NSBtIDU4NiA2OTUgbCBTCkJUIC9GMSAyMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA3NDIgVGQgKEVtcHJlc2EgZXN0dWRpbyBTUEEpIFRqIEVUCkJUIC9GMSAxMSBUZiAwLjEyIDAuMzEgMC40NyByZyA0MzAgNzQ4IFRkIChDT1RJWkFDSU9OKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzM0IFRkIChOXDI2MDogQ09ULTA2OS0wMDAwMDYpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQzMCA3MjAgVGQgKEZlY2hhOiAyMDI2LTA0LTExKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MzAgNzA2IFRkIChWYWxpZGV6OiAyMDI2LTA0LTEzKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA3MjQgVGQgKFJVVDogNzcyMjIzMzMtMykgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNzEwIFRkIChBdi4gVmljdfFhIE1hY2tlbm5hIDM0NSwgQ29uY2VwY2nzbikgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjk2IFRkIChUZWxlZm9ubzogOSA0NTY3IDY3NjcpIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDQwIDY4MiBUZCAoQ29ycmVvOiB2ZXh0cmFjbEBnbWFpbC5jb20pIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCA2NjggVGQgKERhdG9zIGRlbCBjbGllbnRlKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2NTIgVGQgKENsaWVudGU6IFVuaXZlcnNpZGFkIFRlY25vbPNnaWNhIGRlIGxhIEZyb250ZXJhIFMuQS4pIFRqIEVUCkJUIC9GMSA5IFRmIDAgMCAwIHJnIDMwMCA2NTIgVGQgKFJVVDogNzEuNTU2LjAwMC03KSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyA0MCA2MzggVGQgKENvbnRhY3RvOiBVbml2ZXJzaWRhZCBUZWNub2zzZ2ljYSBkZSBsYSBGcm9udGVyYSBTLkEuKSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyAzMDAgNjM4IFRkIChDb3JyZW86IGphdmllcmFhZ29uemFsZXptb2VsbGVyQGdtYWlsLmNvbSkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDAgNjI0IFRkIChUZWxlZm9ubzogKzU2IDkgODkwMCAzNDE4KSBUaiBFVApCVCAvRjEgOSBUZiAwIDAgMCByZyAzMDAgNjI0IFRkIChEaXJlY2Npb246IEF2LiBBbGVtYW5pYSAwNDUwLCBUZW11Y28sIFRlbXVjbykgVGogRVQKQlQgL0YxIDkgVGYgMC4xOCAwLjU1IDAuMzUgcmcgNDAgNjA4IFRkIChEZXNjdWVudG8gcG9yIGxpc3RhIGFwbGljYWRvOiBNYXlvcmlzdGEgMjAyNiAtICQxLjUzNi43NTApIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDQwIDU5NCA1MzIgMTggcmUgZgpCVCAvRjEgOCBUZiAxIDEgMSByZyA0NCA2MDAgVGQgKENvZGlnbykgVGogRVQKQlQgL0YxIDggVGYgMSAxIDEgcmcgMTAwIDYwMCBUZCAoRGVzY3JpcGNpb24pIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDM0NSA2MDAgVGQgKENhbnQuKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyAzOTAgNjAwIFRkIChVbmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDEgMSAxIHJnIDQ1MCA2MDAgVGQgKFAuIFVuaXRhcmlvKSBUaiBFVApCVCAvRjEgOCBUZiAxIDEgMSByZyA1MjAgNjAwIFRkIChUb3RhbCkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTc2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU4NCBUZCAoU1NELVNURS0xVEIpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEwMCA1ODQgVGQgKERpc2NvIFNTRCBFeHRlcm5vIFRlcnJhLVMgU3RlbGxhciAtIFVuaWRhZCBTU0QgcG9ydOF0aWwgMVRCLCBjb25leGnzbiBVU0ItQyAzLjIsIHJlc2lzdGVudGUgYSBnb2xwZXMuKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAzNDggNTg0IFRkICgxLjAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAzOTIgNTg0IFRkICh1bmlkYWQpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ1MiA1ODQgVGQgKCQxMTAuMDAwKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MjIgNTg0IFRkICgkMTExLjI2NSkgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTU2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDU2NCBUZCAoTU9OLU9QVC0yNykgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU2NCBUZCAoTW9uaXRvciBWaXNpb24tVmlldyAyNyIgLSBQYW5lbCBJUFMgNEssIDE0NEh6LCBib3JkZXMgdWx0cmFkZWxnYWRvcy4pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM0OCA1NjQgVGQgKDIuMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDM5MiA1NjQgVGQgKHVuaWRhZCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDUyIDU2NCBUZCAoJDIxNS4wMDApIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUyMiA1NjQgVGQgKCQ0MzQuOTQ1KSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyA0MCA1MzYgNTMyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNDQgNTQ0IFRkIChDUFUtVk9MVC1WOCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDU0NCBUZCAoUHJvY2VzYWRvciBDb3JlLVggVjggLSA4IG76Y2xlb3MsIDE2IGhpbG9zLCBGcmVjdWVuY2lhIDQuMkdIei4gU29ja2V0IEFNNC9MR0EuKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyAzNDggNTQ0IFRkICgzMS4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDU0NCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTQ0IFRkICgkMjg1LjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDU0NCBUZCAoJDguOTM2LjYwMykgVGogRVQKMC44NiAwLjg5IDAuOTIgUkcgMC41IHcgNDAgNTE2IDUzMiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDQ0IDUyNCBUZCAoTEFQLVpFTi0wMSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMTAwIDUyNCBUZCAoTGFwdG9wIFplbml0IHYxNCBQcm8gLSBDUFUgUXVhZC1Db3JlLCAxNkdCIFJBTSwgU1NEIDUxMkdCLiBQYW50YWxsYSAxNCIgRkhELikgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzQ4IDUyNCBUZCAoMS4wMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzkyIDUyNCBUZCAodW5pZGFkKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0NTIgNTI0IFRkICgkODcwLjAwMCkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTIyIDUyNCBUZCAoJDg4MC4wMDUpIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNjAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM2NyBUZCAoU3VidG90YWwpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzNjcgVGQgKCQ4LjcwOC4yNTApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAzNDAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDM0NyBUZCAoRGVzY3VlbnRvKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA1MDAgMzQ3IFRkICgtICQwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzIwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMjcgVGQgKERlc2MuIHBvciBsaXN0YSkgVGogRVQKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAwIDMyNyBUZCAoLSAkMS41MzYuNzUwKSBUaiBFVAowLjg2IDAuODkgMC45MiBSRyAwLjUgdyAzMzAgMzAwIDI0MiAyMCByZSBTCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDMzOCAzMDcgVGQgKE5ldG8pIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAzMDcgVGQgKCQ4LjcwOC4yNTApIFRqIEVUCjAuODYgMC44OSAwLjkyIFJHIDAuNSB3IDMzMCAyODAgMjQyIDIwIHJlIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgMzM4IDI4NyBUZCAoSVZBIFwoMTklXCkpIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDUwMCAyODcgVGQgKCQxLjY1NC41NjgpIFRqIEVUCjAuMTIgMC4zMSAwLjQ3IHJnIDMzMCAyODAgMjQyIDIyIHJlIGYKQlQgL0YxIDkgVGYgMSAxIDEgcmcgMzM4IDI4OCBUZCAoVG90YWwpIFRqIEVUCkJUIC9GMSA5IFRmIDEgMSAxIHJnIDUwMCAyODggVGQgKCQxMC4zNjIuODE4KSBUaiBFVApCVCAvRjEgMTAgVGYgMC4xMiAwLjMxIDAuNDcgcmcgNDAgMjU4IFRkIChPYnNlcnZhY2lvbmVzKSBUaiBFVAowLjk3IDAuOTggMC45OSByZyA0MCAyMTAgNTMyIDQwIHJlIGYKMC4xMiAwLjMxIDAuNDcgUkcgMiB3IDQwIDIxMCBtIDQwIDI1MCBsIFMKQlQgL0YxIDggVGYgMCAwIDAgcmcgNTAgMjM2IFRkICgpIFRqIEVUCkJUIC9GMSAxMCBUZiAwLjEyIDAuMzEgMC40NyByZyA0MCAxOTAgVGQgKFRlcm1pbm9zIHkgY29uZGljaW9uZXMpIFRqIEVUCjAuMyAwLjM1IDAuNCBSRyAxIHcgNzAgNzggbSAyNjAgNzggbCBTCjAuMyAwLjM1IDAuNCBSRyAxIHcgMzUwIDc4IG0gNTQwIDc4IGwgUwpCVCAvRjEgOSBUZiAwIDAgMCByZyAxMzAgNjYgVGQgKEp1YW4gUGVyZXopIFRqIEVUCkJUIC9GMSA4IFRmIDAgMCAwIHJnIDEzMCA1NCBUZCAoRWplY3V0aXZvIENvbWVyY2lhbCkgVGogRVQKQlQgL0YxIDkgVGYgMCAwIDAgcmcgNDIwIDY2IFRkIChVbml2ZXJzaWRhZCBUZWNub2zzZ2ljYSBkZSBsYSBGcm9udGVyYSBTLkEuKSBUaiBFVApCVCAvRjEgOCBUZiAwIDAgMCByZyA0MTAgNTQgVGQgKEFjZXB0YWNpb24gY2xpZW50ZSkgVGogRVQKQlQgL0YxIDcgVGYgMC40IDAuNDUgMC41IHJnIDIxMCAzNiBUZCAoRG9jdW1lbnRvIGdlbmVyYWRvIGF1dG9tYXRpY2FtZW50ZSBwb3IgZWwgc2lzdGVtYSBkZSBjb3RpemFjaW9uZXMuKSBUaiBFVAplbmRzdHJlYW0gZW5kb2JqCnhyZWYKMCA2CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAwOSAwMDAwMCBuIAowMDAwMDAwMDU4IDAwMDAwIG4gCjAwMDAwMDAxMTUgMDAwMDAgbiAKMDAwMDAwMDI0MSAwMDAwMCBuIAowMDAwMDAwMzExIDAwMDAwIG4gCnRyYWlsZXIgPDwgL1NpemUgNiAvUm9vdCAxIDAgUiA+PgpzdGFydHhyZWYKNTE4OAolJUVPRg==\"}],\"link_publico\":\"https:\\/\\/vextra.cl\\/cotizacion\\/publica\\/619ca47311e13911eb364626bd8a1bb969f3802d4bde28fa0657aa9496eb52b0\",\"link_pdf\":\"https:\\/\\/vextra.cl\\/app\\/cotizaciones\\/pdf\\/15\"}', 'enviado', '2026-04-12 23:22:18'),
(42, 'erwin.2785@gmail.com', 'Nuevo mensaje desde contacto del catálogo', 'landing_contacto', '{\"nombre\":\"Municipalidad\",\"correo\":\"erwin.2785@gmail.com\",\"telefono\":\"944627287\",\"empresa\":\"\",\"mensaje\":\"wwwwc\",\"html\":\"<h2>Nuevo mensaje desde contacto de catálogo<\\/h2><p><strong>Nombre:<\\/strong> Municipalidad<\\/p><p><strong>Teléfono:<\\/strong> 944627287<\\/p><p><strong>Email:<\\/strong> erwin.2785@gmail.com<\\/p><p><strong>Asunto:<\\/strong> sdwf<\\/p><p><strong>Mensaje:<\\/strong> wwwwc<\\/p><p><strong>Empresa catálogo:<\\/strong> Pv SportChile<\\/p>\"}', 'enviado', '2026-04-15 02:45:55'),
(43, 'vicente.isla13@gmail.com', 'Resumen de compra catálogo - Pv SportChile', 'catalogo_checkout_resumen', '{\"html\":\"<div style=\\\"font-family:Arial,sans-serif;color:#1f2937\\\"><h2 style=\\\"margin-bottom:8px;\\\">Pago aprobado - Pv SportChile<\\/h2><p>Token Flow: <strong>BDD42E62DF8DA87EEC1C3EA7BFCBE02E55F794CI<\\/strong><\\/p><h3>Datos personales<\\/h3><p><strong>Nombre:<\\/strong> Vicente Isla Mella<br><strong>Correo:<\\/strong> vicente.isla13@gmail.com<br><strong>Teléfono:<\\/strong> +56966938730<br><strong>Documento:<\\/strong> -<br><strong>Empresa:<\\/strong> -<\\/p><h3>Datos de envío<\\/h3><p><strong>Método:<\\/strong> starken<br><strong>Dirección:<\\/strong> Parma 1310<br><strong>Comuna\\/Ciudad:<\\/strong> Los Angeles \\/ Los Angeles<br><strong>Región:<\\/strong> Bio Bio<br><strong>Referencia:<\\/strong> -<\\/p><p><em>Envío por pagar con plazo máximo de 48 horas hábiles desde la confirmación del pago.<\\/em><\\/p><h3>Detalle de compra<\\/h3><table style=\\\"width:100%;border-collapse:collapse;\\\"><tr><td style=\\\"padding:6px 8px;border-bottom:1px solid #e5e7eb;\\\">PRODUCTO DE PRUEBA x1<\\/td><td style=\\\"padding:6px 8px;border-bottom:1px solid #e5e7eb;text-align:right;\\\">$500<\\/td><\\/tr><\\/table><p style=\\\"text-align:right;margin-top:8px;\\\"><strong>Total: $500<\\/strong><\\/p><\\/div>\",\"smtp_global\":{\"host\":\"mail.vextra.cl\",\"puerto\":\"465\",\"usuario\":\"noresponder@vextra.cl\",\"password\":\"Tb*Kz{ny{[_E!%,Q\",\"encryption\":\"ssl\",\"remitente_correo\":\"noresponder@vextra.cl\",\"remitente_nombre\":\"Vextra Notificaciones\"}}', 'enviado', '2026-04-15 15:57:33'),
(44, 'vicente.isla13@gmail.com', 'Resumen de compra catálogo - Pv SportChile', 'catalogo_checkout_resumen', '{\"html\":\"<div style=\\\"font-family:Arial,sans-serif;background:#f4f6fb;padding:20px 0;\\\"><table role=\\\"presentation\\\" style=\\\"width:100%;max-width:700px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\"><tr><td style=\\\"background:#4632a8;color:#fff;padding:18px 24px;\\\"><h2 style=\\\"margin:0;font-size:22px;\\\">Pago aprobado<\\/h2><div style=\\\"margin-top:6px;font-size:13px;opacity:.95;\\\">Pv SportChile<\\/div><\\/td><\\/tr><tr><td style=\\\"padding:20px 24px;color:#1f2937;\\\"><p style=\\\"margin:0 0 10px;\\\"><strong>Token Flow:<\\/strong> EC0F3BE256BEEBD88CA2AA009DE0216F47B85CBC<\\/p><h3 style=\\\"margin:14px 0 8px;font-size:16px;\\\">Datos personales<\\/h3><table style=\\\"width:100%;border-collapse:collapse;font-size:14px;\\\"><tr><td style=\\\"padding:5px 0;\\\"><strong>Nombre:<\\/strong> Vicente Isla Mella<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Correo:<\\/strong> vicente.isla13@gmail.com<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Teléfono:<\\/strong> +56966938730<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Documento:<\\/strong> -<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Empresa:<\\/strong> -<\\/td><\\/tr><\\/table><h3 style=\\\"margin:16px 0 8px;font-size:16px;\\\">Datos de envío<\\/h3><table style=\\\"width:100%;border-collapse:collapse;font-size:14px;\\\"><tr><td style=\\\"padding:5px 0;\\\"><strong>Método:<\\/strong> Starken<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Dirección:<\\/strong> Parma 1310<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Comuna\\/Ciudad:<\\/strong> Los Angeles \\/ Los Angeles<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Región:<\\/strong> Bio Bio<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Referencia:<\\/strong> -<\\/td><\\/tr><\\/table><p style=\\\"margin:10px 0 0;font-size:12px;color:#6b7280;\\\"><em>Envío por pagar con plazo máximo de 48 horas hábiles desde la confirmación del pago.<\\/em><\\/p><h3 style=\\\"margin:18px 0 8px;font-size:16px;\\\">Detalle de compra<\\/h3><table style=\\\"width:100%;border-collapse:collapse;\\\"><tr><td style=\\\"padding:10px 8px;border-bottom:1px solid #e5e7eb;vertical-align:top;width:64px;\\\"><img src=\\\"\\/catalogo\\/77\\/producto\\/48\\/imagen\\\" alt=\\\"PRODUCTO DE PRUEBA\\\" style=\\\"width:52px;height:52px;border-radius:8px;object-fit:cover;background:#f3f4f6\\\"><\\/td><td style=\\\"padding:10px 8px;border-bottom:1px solid #e5e7eb;vertical-align:top;\\\"><div style=\\\"font-weight:600;color:#111827;\\\">PRODUCTO DE PRUEBA x1<\\/div><div style=\\\"font-size:12px;color:#6b7280;margin-top:2px;\\\">PRODUCTO DE PRUEBA<\\/div><\\/td><td style=\\\"padding:10px 8px;border-bottom:1px solid #e5e7eb;text-align:right;font-weight:600;\\\">$500<\\/td><\\/tr><\\/table><p style=\\\"text-align:right;margin:10px 0 0;\\\"><strong>Total: $500<\\/strong><\\/p><\\/td><\\/tr><\\/table><\\/div>\",\"smtp_global\":{\"host\":\"mail.vextra.cl\",\"puerto\":\"465\",\"usuario\":\"noresponder@vextra.cl\",\"password\":\"Tb*Kz{ny{[_E!%,Q\",\"encryption\":\"ssl\",\"remitente_correo\":\"noresponder@vextra.cl\",\"remitente_nombre\":\"Vextra Notificaciones\"}}', 'enviado', '2026-04-15 16:07:47');
INSERT INTO `logs_correos` (`id`, `destinatario`, `asunto`, `plantilla`, `payload`, `estado`, `fecha_creacion`) VALUES
(45, 'vicente.isla13@gmail.com', 'Resumen de compra catálogo - Pv SportChile', 'catalogo_checkout_resumen', '{\"html\":\"<div style=\\\"font-family:Arial,sans-serif;background:#f4f6fb;padding:20px 0;\\\"><table role=\\\"presentation\\\" style=\\\"width:100%;max-width:700px;margin:0 auto;background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;overflow:hidden;\\\"><tr><td style=\\\"background:#4632a8;color:#fff;padding:18px 24px;\\\"><h2 style=\\\"margin:0;font-size:22px;\\\">Pago aprobado<\\/h2><div style=\\\"margin-top:6px;font-size:13px;opacity:.95;\\\">Pv SportChile<\\/div><\\/td><\\/tr><tr><td style=\\\"padding:20px 24px;color:#1f2937;\\\"><p style=\\\"margin:0 0 10px;\\\"><strong>Token Flow:<\\/strong> 366BA514FBAF6D8E7FA4488EF9952C9EECFE097K<\\/p><h3 style=\\\"margin:14px 0 8px;font-size:16px;\\\">Datos personales<\\/h3><table style=\\\"width:100%;border-collapse:collapse;font-size:14px;\\\"><tr><td style=\\\"padding:5px 0;\\\"><strong>Nombre:<\\/strong> Vicente Isla Mella<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Correo:<\\/strong> vicente.isla13@gmail.com<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Teléfono:<\\/strong> +56966938730<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Documento:<\\/strong> -<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Empresa:<\\/strong> -<\\/td><\\/tr><\\/table><h3 style=\\\"margin:16px 0 8px;font-size:16px;\\\">Datos de envío<\\/h3><table style=\\\"width:100%;border-collapse:collapse;font-size:14px;\\\"><tr><td style=\\\"padding:5px 0;\\\"><strong>Método:<\\/strong> Starken<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Dirección:<\\/strong> Parma 1310<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Comuna\\/Ciudad:<\\/strong> Los Angeles \\/ Los Angeles<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Región:<\\/strong> Bio Bio<\\/td><\\/tr><tr><td style=\\\"padding:5px 0;\\\"><strong>Referencia:<\\/strong> -<\\/td><\\/tr><\\/table><p style=\\\"margin:10px 0 0;font-size:12px;color:#6b7280;\\\"><em>Envío por pagar con plazo máximo de 48 horas hábiles desde la confirmación del pago.<\\/em><\\/p><div style=\\\"margin:14px 0 2px;padding:12px 14px;border:1px solid #bbf7d0;background:#f0fdf4;border-radius:10px;\\\"><div style=\\\"font-size:14px;font-weight:700;color:#166534;margin-bottom:6px;\\\">Productos reservados en este pedido<\\/div><ul style=\\\"margin:0 0 8px 18px;padding:0;color:#14532d;font-size:13px;\\\"><li style=\\\"margin:4px 0;\\\"><strong>Loki Arthur Green<\\/strong> · Cantidad: 1 · Llegada estimada: 11 día(s)<\\/li><\\/ul><div style=\\\"font-size:12px;color:#166534;\\\">Para darte mayor seguridad, los productos reservados se enviarán por separado según su fecha de llegada, sin afectar los productos con entrega inmediata.<\\/div><\\/div><h3 style=\\\"margin:18px 0 8px;font-size:16px;\\\">Detalle de compra<\\/h3><table style=\\\"width:100%;border-collapse:collapse;\\\"><tr><td style=\\\"padding:10px 8px;border-bottom:1px solid #e5e7eb;vertical-align:top;width:64px;\\\"><img src=\\\"https:\\/\\/vextra.cl\\/catalogo\\/77\\/producto\\/70\\/imagen\\\" alt=\\\"Loki Arthur Green\\\" style=\\\"width:52px;height:52px;border-radius:8px;object-fit:cover;background:#f3f4f6\\\"><\\/td><td style=\\\"padding:10px 8px;border-bottom:1px solid #e5e7eb;vertical-align:top;\\\"><div style=\\\"font-weight:600;color:#111827;\\\">Loki Arthur Green x1<\\/div><div style=\\\"font-size:12px;color:#6b7280;margin-top:2px;\\\">Estás en nivel principiante avanzado o intermedio Juegas con loops, control y colocación Quieres una goma cómoda para r…<\\/div><div style=\\\"font-size:12px;color:#166534;margin-top:3px;font-weight:600;\\\">Reserva confirmada · llega en 11 día(s).<\\/div><\\/td><td style=\\\"padding:10px 8px;border-bottom:1px solid #e5e7eb;text-align:right;font-weight:600;\\\">$500<\\/td><\\/tr><\\/table><p style=\\\"text-align:right;margin:10px 0 0;\\\"><strong>Total: $500<\\/strong><\\/p><\\/td><\\/tr><\\/table><\\/div>\",\"smtp_global\":{\"host\":\"mail.vextra.cl\",\"puerto\":\"465\",\"usuario\":\"noresponder@vextra.cl\",\"password\":\"Tb*Kz{ny{[_E!%,Q\",\"encryption\":\"ssl\",\"remitente_correo\":\"noresponder@vextra.cl\",\"remitente_nombre\":\"Vextra Notificaciones\"}}', 'enviado', '2026-04-16 23:06:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_pagos`
--

CREATE TABLE `logs_pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `pago_id` bigint UNSIGNED DEFAULT NULL,
  `tipo_evento` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `respuesta` text COLLATE utf8mb4_unicode_ci,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_caja_pos`
--

CREATE TABLE `movimientos_caja_pos` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `caja_id` bigint UNSIGNED NOT NULL,
  `apertura_caja_id` bigint UNSIGNED NOT NULL,
  `tipo_movimiento` enum('ingreso_venta','egreso_manual','ingreso_manual') COLLATE utf8mb4_unicode_ci NOT NULL,
  `concepto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `fecha_movimiento` datetime NOT NULL,
  `venta_pos_id` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `movimientos_caja_pos`
--

INSERT INTO `movimientos_caja_pos` (`id`, `empresa_id`, `caja_id`, `apertura_caja_id`, `tipo_movimiento`, `concepto`, `monto`, `usuario_id`, `fecha_movimiento`, `venta_pos_id`) VALUES
(1, 69, 1, 1, 'ingreso_venta', 'Venta POS POS-069-00000001', 991270.00, 70, '2026-04-08 15:52:55', 1),
(2, 69, 1, 1, 'ingreso_venta', 'Venta POS POS-069-00000002', 458150.00, 70, '2026-04-08 15:55:44', 2),
(3, 69, 1, 1, 'ingreso_venta', 'Venta POS POS-069-00000003', 77350.00, 70, '2026-04-08 16:03:35', 3),
(4, 69, 1, 1, 'ingreso_venta', 'Venta POS POS-069-00000004', 380800.00, 70, '2026-04-09 01:43:44', 4),
(5, 69, 1, 2, 'ingreso_venta', 'Venta POS POS-069-00000005', 285302.50, 70, '2026-04-09 21:31:00', 5),
(6, 73, 2, 3, 'ingreso_venta', 'Venta POS POS-073-00000001', 10710.00, 74, '2026-04-11 11:58:20', 6),
(7, 73, 2, 3, 'ingreso_venta', 'Venta POS POS-073-00000002', 107100.00, 74, '2026-04-11 13:29:49', 7),
(8, 73, 2, 3, 'ingreso_venta', 'Venta POS POS-073-00000003', 32130.00, 74, '2026-04-11 13:30:08', 8),
(9, 73, 2, 3, 'ingreso_venta', 'Venta POS POS-073-00000004', 42840.00, 74, '2026-04-11 13:30:33', 9),
(10, 73, 2, 3, 'ingreso_venta', 'Venta POS POS-073-00000005', 29155.00, 74, '2026-04-11 13:30:55', 10),
(11, 73, 3, 4, 'ingreso_venta', 'Venta POS POS-073-00000006', 40530.21, 74, '2026-04-11 14:32:09', 11),
(12, 73, 4, 5, 'ingreso_venta', 'Venta POS POS-073-00000007', 43316.00, 74, '2026-04-11 18:18:14', 12),
(18, 69, 1, 2, 'ingreso_venta', 'Venta POS POS-069-00000006', 323680.00, 70, '2026-04-12 23:12:02', 17);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_inventario`
--

CREATE TABLE `movimientos_inventario` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `tipo_movimiento` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `modulo_origen` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `documento_origen` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referencia_id` bigint UNSIGNED DEFAULT NULL,
  `entrada` decimal(12,2) NOT NULL DEFAULT '0.00',
  `salida` decimal(12,2) NOT NULL DEFAULT '0.00',
  `saldo_resultante` decimal(12,2) NOT NULL DEFAULT '0.00',
  `observacion` text COLLATE utf8mb4_unicode_ci,
  `usuario_id` bigint UNSIGNED DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `movimientos_inventario`
--

INSERT INTO `movimientos_inventario` (`id`, `empresa_id`, `producto_id`, `tipo_movimiento`, `modulo_origen`, `documento_origen`, `referencia_id`, `entrada`, `salida`, `saldo_resultante`, `observacion`, `usuario_id`, `fecha_creacion`) VALUES
(1, 69, 2, 'recepcion_proveedor', 'recepciones_inventario', 'factura #4520', 1, 10.00, 0.00, 35.00, 'Recepción conforme de hardware crítico. Se valida estado físico de los componentes.', 70, '2026-04-08 14:57:57'),
(2, 69, 3, 'ajuste_salida', 'ajustes_inventario', 'ajuste #1', 1, 0.00, 2.00, 18.00, 'danio Monitor con pantalla quebrada detectado durante el movimiento de estanterías.', 70, '2026-04-08 15:01:42'),
(3, 69, 4, 'ajuste_entrada', 'ajustes_inventario', 'ajuste #2', 2, 2.00, 0.00, 17.00, 'diferencia_conteo Unidades encontradas en bodega que no estaban ingresadas en el sistema tras inventario físico.', 70, '2026-04-08 15:02:12'),
(4, 69, 5, 'ajuste_entrada', 'ajustes_inventario', 'ajuste #3', 3, 1.00, 0.00, 18.00, 'devolucion', 70, '2026-04-08 15:33:04'),
(5, 69, 3, 'recepcion_proveedor', 'recepciones_inventario', 'guia_despacho #8821', 2, 12.00, 0.00, 30.00, 'Recepción de periféricos para stock de temporada. Se verifica integridad de empaques.', 70, '2026-04-08 15:38:06'),
(6, 69, 1, 'ajuste_salida', 'ajustes_inventario', 'ajuste #4', 4, 0.00, 1.00, 13.00, 'merma Equipo retirado del inventario para ser utilizado como unidad de demostración (Demo) en el mesón de atención a clientes. No apto para la venta posterior.', 70, '2026-04-08 15:39:36'),
(7, 69, 1, 'venta_pos', 'punto_venta', 'POS-069-00000001', 1, 0.00, 1.00, 12.00, 'Salida por venta POS', 70, '2026-04-08 15:52:55'),
(8, 69, 5, 'venta_pos', 'punto_venta', 'POS-069-00000001', 1, 0.00, 1.00, 17.00, 'Salida por venta POS', 70, '2026-04-08 15:52:55'),
(9, 69, 2, 'venta_pos', 'punto_venta', 'POS-069-00000002', 2, 0.00, 1.00, 34.00, 'Salida por venta POS', 70, '2026-04-08 15:55:44'),
(10, 69, 2, 'venta_pos', 'punto_venta', 'POS-069-00000004', 4, 0.00, 1.00, 33.00, 'Salida por venta POS', 70, '2026-04-09 01:43:44'),
(11, 69, 3, 'venta_pos', 'punto_venta', 'POS-069-00000005', 5, 0.00, 1.00, 29.00, 'Salida por venta POS', 70, '2026-04-09 21:31:00'),
(12, 73, 8, 'ajuste_entrada', 'ajustes_inventario', 'ajuste #5', 5, 100.00, 0.00, 300.00, 'correccion_inventario', 74, '2026-04-11 11:39:37'),
(13, 73, 9, 'ajuste_entrada', 'ajustes_inventario', 'ajuste #6', 6, 25.00, 0.00, 125.00, 'correccion_inventario', 74, '2026-04-11 11:52:03'),
(14, 73, 8, 'ajuste_salida', 'ajustes_inventario', 'ajuste #7', 7, 0.00, 20.00, 280.00, 'correccion_inventario', 74, '2026-04-11 11:53:53'),
(15, 73, 9, 'venta_pos', 'punto_venta', 'POS-073-00000001', 6, 0.00, 1.00, 124.00, 'Salida por venta POS', 74, '2026-04-11 11:58:20'),
(16, 73, 8, 'venta_pos', 'punto_venta', 'POS-073-00000001', 6, 0.00, 1.00, 279.00, 'Salida por venta POS', 74, '2026-04-11 11:58:20'),
(17, 73, 12, 'ajuste_entrada', 'ajustes_inventario', 'ajuste #8', 8, 20.00, 0.00, 100.00, 'correccion_inventario', 74, '2026-04-11 13:27:22'),
(18, 73, 11, 'venta_pos', 'punto_venta', 'POS-073-00000002', 7, 0.00, 3.00, 77.00, 'Salida por venta POS', 74, '2026-04-11 13:29:49'),
(19, 73, 12, 'venta_pos', 'punto_venta', 'POS-073-00000002', 7, 0.00, 2.00, 98.00, 'Salida por venta POS', 74, '2026-04-11 13:29:49'),
(20, 73, 12, 'venta_pos', 'punto_venta', 'POS-073-00000003', 8, 0.00, 1.00, 97.00, 'Salida por venta POS', 74, '2026-04-11 13:30:08'),
(21, 73, 8, 'venta_pos', 'punto_venta', 'POS-073-00000003', 8, 0.00, 1.00, 278.00, 'Salida por venta POS', 74, '2026-04-11 13:30:08'),
(22, 73, 9, 'venta_pos', 'punto_venta', 'POS-073-00000003', 8, 0.00, 1.00, 123.00, 'Salida por venta POS', 74, '2026-04-11 13:30:08'),
(23, 73, 12, 'venta_pos', 'punto_venta', 'POS-073-00000004', 9, 0.00, 1.00, 96.00, 'Salida por venta POS', 74, '2026-04-11 13:30:33'),
(24, 73, 11, 'venta_pos', 'punto_venta', 'POS-073-00000004', 9, 0.00, 1.00, 76.00, 'Salida por venta POS', 74, '2026-04-11 13:30:33'),
(25, 73, 9, 'venta_pos', 'punto_venta', 'POS-073-00000005', 10, 0.00, 1.00, 122.00, 'Salida por venta POS', 74, '2026-04-11 13:30:55'),
(26, 73, 12, 'venta_pos', 'punto_venta', 'POS-073-00000005', 10, 0.00, 1.00, 95.00, 'Salida por venta POS', 74, '2026-04-11 13:30:55'),
(28, 73, 13, 'ajuste_entrada', 'ajustes_inventario', 'ajuste #9', 9, 20.00, 0.00, 110.00, 'correccion_inventario', 74, '2026-04-11 14:31:46'),
(29, 73, 13, 'venta_pos', 'punto_venta', 'POS-073-00000006', 11, 0.00, 1.01, 108.99, 'Salida por venta POS', 74, '2026-04-11 14:32:09'),
(30, 73, 11, 'venta_pos', 'punto_venta', 'POS-073-00000006', 11, 0.00, 1.00, 80.00, 'Salida por venta POS', 74, '2026-04-11 14:32:09'),
(31, 73, 13, 'ajuste_salida', 'ajustes_inventario', 'ajuste #10', 10, 0.00, 20.00, 88.99, 'correccion_inventario', 74, '2026-04-11 14:36:39'),
(32, 73, 13, 'venta_pos', 'punto_venta', 'POS-073-00000007', 12, 0.00, 1.00, 87.99, 'Salida por venta POS', 74, '2026-04-11 18:18:14'),
(33, 73, 11, 'venta_pos', 'punto_venta', 'POS-073-00000007', 12, 0.00, 1.00, 79.00, 'Salida por venta POS', 74, '2026-04-11 18:18:14'),
(34, 73, 8, 'venta_pos', 'punto_venta', 'POS-073-00000007', 12, 0.00, 1.00, 277.00, 'Salida por venta POS', 74, '2026-04-11 18:18:14'),
(59, 69, 4, 'venta_pos', 'punto_venta', 'POS-069-00000006', 17, 0.00, 1.00, 16.00, 'Salida por venta POS', 70, '2026-04-12 23:12:02'),
(60, 69, 5, 'venta_pos', 'punto_venta', 'POS-069-00000006', 17, 0.00, 1.00, 16.00, 'Salida por venta POS', 70, '2026-04-12 23:12:02'),
(61, 77, 48, 'salida_catalogo', 'catalogo_checkout', 'Compra catálogo #3', 3, 0.00, 1.00, 3.00, 'Descuento automático por compra aprobada en catálogo. Token: F578CE0A71B8ABF73161EF5587F26EE0462B181Z', NULL, '2026-04-15 15:24:44'),
(62, 77, 48, 'salida_catalogo', 'catalogo_checkout', 'Compra catálogo #6', 6, 0.00, 1.00, 2.00, 'Descuento automático por compra aprobada en catálogo. Token: BDD42E62DF8DA87EEC1C3EA7BFCBE02E55F794CI', NULL, '2026-04-15 15:57:28'),
(63, 77, 48, 'salida_catalogo', 'catalogo_checkout', 'Compra catálogo #7', 7, 0.00, 1.00, 1.00, 'Descuento automático por compra aprobada en catálogo. Token: EC0F3BE256BEEBD88CA2AA009DE0216F47B85CBC', NULL, '2026-04-15 16:07:45'),
(64, 77, 70, 'salida_catalogo', 'catalogo_checkout', 'Compra catálogo #8', 8, 0.00, 1.00, 19.00, 'Descuento automático por compra aprobada en catálogo. Token: 366BA514FBAF6D8E7FA4488EF9952C9EECFE097K', NULL, '2026-04-16 23:06:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_inventario_pos`
--

CREATE TABLE `movimientos_inventario_pos` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `venta_pos_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `tipo_movimiento` enum('salida_venta','ajuste_manual') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'salida_venta',
  `cantidad` decimal(12,2) NOT NULL,
  `stock_anterior` decimal(12,2) NOT NULL,
  `stock_actual` decimal(12,2) NOT NULL,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `fecha_movimiento` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `movimientos_inventario_pos`
--

INSERT INTO `movimientos_inventario_pos` (`id`, `empresa_id`, `venta_pos_id`, `producto_id`, `tipo_movimiento`, `cantidad`, `stock_anterior`, `stock_actual`, `usuario_id`, `fecha_movimiento`) VALUES
(1, 69, 1, 1, 'salida_venta', 1.00, 13.00, 12.00, 70, '2026-04-08 15:52:55'),
(2, 69, 1, 5, 'salida_venta', 1.00, 18.00, 17.00, 70, '2026-04-08 15:52:55'),
(3, 69, 2, 2, 'salida_venta', 1.00, 35.00, 34.00, 70, '2026-04-08 15:55:44'),
(4, 69, 4, 2, 'salida_venta', 1.00, 34.00, 33.00, 70, '2026-04-09 01:43:44'),
(5, 69, 5, 3, 'salida_venta', 1.00, 30.00, 29.00, 70, '2026-04-09 21:31:00'),
(6, 73, 6, 9, 'salida_venta', 1.00, 125.00, 124.00, 74, '2026-04-11 11:58:20'),
(7, 73, 6, 8, 'salida_venta', 1.00, 280.00, 279.00, 74, '2026-04-11 11:58:20'),
(8, 73, 7, 11, 'salida_venta', 3.00, 80.00, 77.00, 74, '2026-04-11 13:29:49'),
(9, 73, 7, 12, 'salida_venta', 2.00, 100.00, 98.00, 74, '2026-04-11 13:29:49'),
(10, 73, 8, 12, 'salida_venta', 1.00, 98.00, 97.00, 74, '2026-04-11 13:30:08'),
(11, 73, 8, 8, 'salida_venta', 1.00, 279.00, 278.00, 74, '2026-04-11 13:30:08'),
(12, 73, 8, 9, 'salida_venta', 1.00, 124.00, 123.00, 74, '2026-04-11 13:30:08'),
(13, 73, 9, 12, 'salida_venta', 1.00, 97.00, 96.00, 74, '2026-04-11 13:30:33'),
(14, 73, 9, 11, 'salida_venta', 1.00, 77.00, 76.00, 74, '2026-04-11 13:30:33'),
(15, 73, 10, 9, 'salida_venta', 1.00, 123.00, 122.00, 74, '2026-04-11 13:30:55'),
(16, 73, 10, 12, 'salida_venta', 1.00, 96.00, 95.00, 74, '2026-04-11 13:30:55'),
(17, 73, 11, 13, 'salida_venta', 1.01, 110.00, 108.99, 74, '2026-04-11 14:32:09'),
(18, 73, 11, 11, 'salida_venta', 1.00, 81.00, 80.00, 74, '2026-04-11 14:32:09'),
(19, 73, 12, 13, 'salida_venta', 1.00, 88.99, 87.99, 74, '2026-04-11 18:18:14'),
(20, 73, 12, 11, 'salida_venta', 1.00, 80.00, 79.00, 74, '2026-04-11 18:18:14'),
(21, 73, 12, 8, 'salida_venta', 1.00, 278.00, 277.00, 74, '2026-04-11 18:18:14'),
(30, 69, 17, 4, 'salida_venta', 1.00, 17.00, 16.00, 70, '2026-04-12 23:12:02'),
(31, 69, 17, 5, 'salida_venta', 1.00, 17.00, 16.00, 70, '2026-04-12 23:12:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones_empresa`
--

CREATE TABLE `notificaciones_empresa` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sistema',
  `titulo` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mensaje` text COLLATE utf8mb4_unicode_ci,
  `estado` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pendiente',
  `fecha_evento` date DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificaciones_empresa`
--

INSERT INTO `notificaciones_empresa` (`id`, `empresa_id`, `tipo`, `titulo`, `mensaje`, `estado`, `fecha_evento`, `fecha_creacion`) VALUES
(1, 69, 'Sistema', 'Alerta de Stock Crítico: Router Mesh Omni-Link W6', 'El producto ha alcanzado el umbral crítico de 4 unidades. Favor gestionar reposición inmediata con el proveedor asignado.', 'pendiente', '2026-04-11', '2026-04-12 22:04:47'),
(2, 69, 'Sistema', 'Cierre de Caja Exitoso - Punto de Venta 01', 'El cierre de caja se ha realizado correctamente por el monto de $2.377.350. No se detectaron descuadres en el conteo final.', 'leida', '2026-04-01', '2026-04-12 22:05:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenes_compra`
--

CREATE TABLE `ordenes_compra` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `proveedor_id` bigint UNSIGNED NOT NULL,
  `numero` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_emision` date NOT NULL,
  `fecha_entrega_estimada` date DEFAULT NULL,
  `estado` enum('borrador','emitida','parcial','recibida','recepcionada','aprobada','rechazada','anulada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'emitida',
  `referencia` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacion` text COLLATE utf8mb4_unicode_ci,
  `usuario_id` bigint UNSIGNED DEFAULT NULL,
  `token_publico` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ordenes_compra`
--

INSERT INTO `ordenes_compra` (`id`, `empresa_id`, `proveedor_id`, `numero`, `fecha_emision`, `fecha_entrega_estimada`, `estado`, `referencia`, `observacion`, `usuario_id`, `token_publico`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 69, 1, 'OC-069-000001', '2026-04-08', '2026-04-15', 'emitida', 'OC-Hardware-Abril', 'Pedido urgente para reponer stock de procesadores.', 70, 'dcee59e833816c7b08e1986933a93acba500e676d63d6128a50a3284657525df', '2026-04-08 14:46:00', '2026-04-08 15:06:29'),
(2, 69, 2, 'OC-069-000002', '2026-04-08', '2026-04-13', 'emitida', 'OC-Perif-001', 'Compra mensual de accesorios para stock de vitrina.', 70, '1292c14c0e21bf93fa053873a0a9770ca350bbb9430b87b10e30be9e2d9ec7bd', '2026-04-08 14:49:32', '2026-04-08 15:12:57'),
(3, 69, 3, 'OC-069-000003', '2026-04-06', '2026-04-13', 'emitida', 'CONTRATO-REDES-2026', 'Insumos para el proyecto de instalación de red corporativa.', 1, '7a65cba647879688c7542d43cb1d9d64480b144a7907f8ac0b90e2403a238b16', '2026-04-08 14:50:21', '2026-04-08 15:06:59'),
(4, 73, 4, 'OC-073-000001', '2026-04-11', '2026-04-18', 'emitida', '', '', 74, '47caf787249e50e2d1b702ea02e0f063d4e1c0d2448c048f6c712d3dcd5739e0', '2026-04-11 11:31:03', NULL),
(5, 73, 6, 'OC-073-0000022', '2026-04-11', '2026-04-30', 'aprobada', '', '', 74, '8f30e44835464b36d9d60c8ef8d6f3e38dd29dfd29e3e8fd92632f9a60c92dd7', '2026-04-11 14:11:24', '2026-04-11 19:34:29'),
(6, 73, 7, 'OC-073-000003', '2026-04-11', '2026-04-18', 'aprobada', '', '', 74, '7a637e91a4f7c6d0b406ef3dbb35a5416d31d6fea5b29ebf3d415eff9432fca6', '2026-04-11 14:39:34', '2026-04-11 19:33:01'),
(7, 73, 8, 'OC-073-000004', '2026-04-11', '2026-04-18', 'aprobada', '', '', 74, '5a30864002a2ffffbece3bbbfd04800616ad11bf981b96d565988da11b514cbb', '2026-04-11 19:00:16', '2026-04-11 19:33:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenes_compra_detalle`
--

CREATE TABLE `ordenes_compra_detalle` (
  `id` bigint UNSIGNED NOT NULL,
  `orden_compra_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `cantidad` decimal(12,2) NOT NULL,
  `costo_unitario` decimal(12,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ordenes_compra_detalle`
--

INSERT INTO `ordenes_compra_detalle` (`id`, `orden_compra_id`, `producto_id`, `cantidad`, `costo_unitario`, `subtotal`, `fecha_creacion`) VALUES
(2, 1, 2, 10.00, 195000.00, 1950000.00, '2026-04-08 14:48:11'),
(3, 2, 3, 8.00, 145000.00, 1160000.00, '2026-04-08 14:49:32'),
(7, 3, 4, 4.00, 88000.00, 352000.00, '2026-04-08 15:06:59'),
(8, 4, 8, 25.00, 2500.00, 62500.00, '2026-04-11 11:31:03'),
(9, 5, 11, 4.00, 25000.00, 100000.00, '2026-04-11 14:11:24'),
(10, 6, 13, 1.00, 18000.00, 18000.00, '2026-04-11 14:39:34'),
(11, 7, 11, 2.00, 0.00, 0.00, '2026-04-11 19:00:16'),
(12, 7, 12, 5.00, 0.00, 0.00, '2026-04-11 19:00:16'),
(13, 7, 13, 4.00, 0.00, 0.00, '2026-04-11 19:00:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `suscripcion_id` bigint UNSIGNED NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `moneda` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `metodo` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frecuencia` enum('mensual','anual') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('pendiente','aprobado','rechazado','anulado') COLLATE utf8mb4_unicode_ci NOT NULL,
  `flow_status` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entorno_flow` enum('sandbox','produccion') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `commerce_order` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referencia_externa` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flow_payment_id` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flow_token` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `payload_request` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `payload_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `fecha_pago` datetime NOT NULL,
  `fecha_confirmacion` datetime DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `empresa_id`, `suscripcion_id`, `monto`, `moneda`, `metodo`, `frecuencia`, `estado`, `flow_status`, `entorno_flow`, `commerce_order`, `referencia_externa`, `flow_payment_id`, `flow_token`, `observaciones`, `payload`, `payload_request`, `payload_response`, `fecha_pago`, `fecha_confirmacion`, `fecha_creacion`) VALUES
(35, 69, 50, 500.00, 'CLP', 'flow', 'mensual', 'aprobado', '2', NULL, NULL, 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', '165616534', 'DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J', 'Pago creado por panel administrador', '{\"token\":\"DBEA592BB8F7A444FDF9EA3F11021FDB72DE5F1J\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":165616534}', NULL, '{\"flowOrder\":165616534,\"commerceOrder\":\"EMP69-PLAN2-3C4DAF08\",\"requestDate\":\"2026-04-08 03:49:24\",\"status\":2,\"subject\":\"Cobro inicial plan por registro Profesional Emprende (mensual)\",\"currency\":\"CLP\",\"amount\":\"500\",\"payer\":\"javigonzalez2024@udec.cl\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":\"2026-04-08 03:53:44\",\"media\":\"Webpay\",\"conversionDate\":null,\"conversionRate\":null,\"amount\":\"500.00\",\"currency\":\"CLP\",\"fee\":\"16.00\",\"balance\":481,\"transferDate\":\"2026-04-09 00:00:00\",\"taxes\":3},\"merchantId\":null}', '2026-04-08 02:49:24', '2026-04-08 02:53:49', '2026-04-08 03:49:24'),
(37, 69, 50, 17000.00, 'CLP', 'flow', 'mensual', 'pendiente', NULL, NULL, NULL, '18DD692479BDEE68BCF72EF4457AB17BD3D9687R', NULL, NULL, 'Pago creado por panel administrador', '{\"token\":\"18DD692479BDEE68BCF72EF4457AB17BD3D9687R\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":165896142}', NULL, NULL, '2026-04-11 01:31:25', NULL, '2026-04-11 02:31:25'),
(38, 73, 54, 55000.00, 'CLP', 'flow', 'mensual', 'pendiente', NULL, NULL, NULL, 'DBA392B643A11411B4FDC48E3F4DE802D9E503CY', NULL, NULL, 'Pago creado por panel administrador', '{\"token\":\"DBA392B643A11411B4FDC48E3F4DE802D9E503CY\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":165966431}', NULL, NULL, '2026-04-11 21:50:14', NULL, '2026-04-11 22:50:14'),
(39, 73, 54, 55000.00, 'CLP', 'flow', 'mensual', 'pendiente', '1', NULL, NULL, 'CDE9F0765F186BFB86963FCCD36444B4F6006C0U', '165980370', 'CDE9F0765F186BFB86963FCCD36444B4F6006C0U', 'Pago creado por panel administrador', '{\"token\":\"CDE9F0765F186BFB86963FCCD36444B4F6006C0U\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":165980370}', NULL, '{\"flowOrder\":165980370,\"commerceOrder\":\"EMP73-PLAN3-069276C7\",\"requestDate\":\"2026-04-12 02:59:24\",\"status\":1,\"subject\":\"Activación del plan al finalizar periodo de prueba Empresa Full (mensual)\",\"currency\":\"CLP\",\"amount\":\"55000\",\"payer\":\"soledadmellazuniga@gmail.com\",\"optional\":null,\"pending_info\":{\"media\":null,\"date\":null},\"paymentData\":{\"date\":null,\"media\":null,\"conversionDate\":null,\"conversionRate\":null,\"amount\":null,\"currency\":null,\"fee\":null,\"balance\":null,\"transferDate\":null},\"merchantId\":null}', '2026-04-12 01:59:24', NULL, '2026-04-12 02:59:24'),
(40, 73, 54, 132498.00, 'CLP', 'flow', 'anual', 'pendiente', NULL, NULL, NULL, '31528ACF0A7586A68B42C1FFE1FDC8C7306E3E4G', NULL, NULL, 'Pago creado por panel administrador', '{\"token\":\"31528ACF0A7586A68B42C1FFE1FDC8C7306E3E4G\",\"url\":\"https:\\/\\/www.flow.cl\\/app\\/web\\/pay.php\",\"flowOrder\":166036214}', NULL, NULL, '2026-04-12 19:38:08', NULL, '2026-04-12 20:38:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos_venta_pos`
--

CREATE TABLE `pagos_venta_pos` (
  `id` bigint UNSIGNED NOT NULL,
  `venta_pos_id` bigint UNSIGNED NOT NULL,
  `metodo_pago` enum('efectivo','transferencia','tarjeta') COLLATE utf8mb4_unicode_ci NOT NULL,
  `monto` decimal(12,2) NOT NULL DEFAULT '0.00',
  `referencia` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_pago` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pagos_venta_pos`
--

INSERT INTO `pagos_venta_pos` (`id`, `venta_pos_id`, `metodo_pago`, `monto`, `referencia`, `fecha_pago`) VALUES
(1, 1, 'efectivo', 700000.00, '', '2026-04-08 15:52:55'),
(2, 2, 'transferencia', 300000.00, '', '2026-04-08 15:55:44'),
(3, 2, 'efectivo', 160000.00, '', '2026-04-08 15:55:44'),
(4, 3, 'tarjeta', 77350.00, '', '2026-04-08 16:03:35'),
(5, 4, 'transferencia', 1000000.00, '', '2026-04-09 01:43:44'),
(6, 4, 'efectivo', 40000.00, '', '2026-04-09 01:43:44'),
(7, 5, 'tarjeta', 285.30, '', '2026-04-09 21:31:00'),
(8, 6, 'efectivo', 8000.00, '', '2026-04-11 11:58:20'),
(9, 6, 'tarjeta', 10000.00, '', '2026-04-11 11:58:20'),
(10, 7, 'efectivo', 110000.00, '', '2026-04-11 13:29:49'),
(11, 8, 'tarjeta', 32130.00, '', '2026-04-11 13:30:08'),
(12, 9, 'efectivo', 50000.00, '', '2026-04-11 13:30:33'),
(13, 9, 'tarjeta', 2840.00, '', '2026-04-11 13:30:33'),
(14, 10, 'transferencia', 29155.00, '', '2026-04-11 13:30:55'),
(15, 11, 'efectivo', 50000.00, '', '2026-04-11 14:32:09'),
(16, 12, 'efectivo', 45000.00, '', '2026-04-11 18:18:14'),
(21, 17, 'efectivo', 300000.00, '', '2026-04-12 23:12:02'),
(22, 17, 'transferencia', 23680.00, '', '2026-04-12 23:12:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id`, `nombre`, `codigo`, `fecha_creacion`) VALUES
(1, 'Acceso panel admin', 'panel_admin', '2026-04-07 01:23:58'),
(2, 'Gestión planes', 'planes', '2026-04-07 01:23:58'),
(3, 'Gestión funcionalidades', 'funcionalidades', '2026-04-07 01:23:58'),
(4, 'Gestión suscripciones', 'suscripciones', '2026-04-07 01:23:58'),
(5, 'Gestión clientes', 'clientes', '2026-04-07 01:23:58'),
(6, 'Gestión productos', 'productos', '2026-04-07 01:23:58'),
(7, 'Gestión cotizaciones', 'cotizaciones', '2026-04-07 01:23:58'),
(8, 'Panel empresa', 'panel_empresa', '2026-04-07 01:23:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planes`
--

CREATE TABLE `planes` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion_comercial` text COLLATE utf8mb4_unicode_ci,
  `precio_mensual` decimal(12,2) NOT NULL DEFAULT '0.00',
  `descuento_anual_pct` decimal(5,2) NOT NULL DEFAULT '0.00',
  `precio_anual` decimal(12,2) NOT NULL DEFAULT '0.00',
  `duracion_dias` int NOT NULL DEFAULT '30',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `destacado` tinyint(1) NOT NULL DEFAULT '0',
  `recomendado` tinyint(1) NOT NULL DEFAULT '0',
  `orden_visualizacion` int NOT NULL DEFAULT '0',
  `insignia` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resumen_comercial` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color_visual` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maximo_usuarios` int NOT NULL DEFAULT '1',
  `usuarios_ilimitados` tinyint(1) NOT NULL DEFAULT '0',
  `observaciones_internas` text COLLATE utf8mb4_unicode_ci,
  `estado` enum('activo','inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `flow_plan_id_mensual` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flow_plan_id_anual` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flow_sincronizado` tinyint(1) NOT NULL DEFAULT '0',
  `flow_ultima_sincronizacion` datetime DEFAULT NULL,
  `flow_dias_prueba` smallint NOT NULL DEFAULT '0',
  `flow_dias_cobro` smallint NOT NULL DEFAULT '3',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `planes`
--

INSERT INTO `planes` (`id`, `nombre`, `slug`, `descripcion_comercial`, `precio_mensual`, `descuento_anual_pct`, `precio_anual`, `duracion_dias`, `visible`, `destacado`, `recomendado`, `orden_visualizacion`, `insignia`, `resumen_comercial`, `color_visual`, `maximo_usuarios`, `usuarios_ilimitados`, `observaciones_internas`, `estado`, `flow_plan_id_mensual`, `flow_plan_id_anual`, `flow_sincronizado`, `flow_ultima_sincronizacion`, `flow_dias_prueba`, `flow_dias_cobro`, `fecha_creacion`, `fecha_actualizacion`, `fecha_eliminacion`) VALUES
(1, 'Básico', 'basico', 'Plan de entrada para operar cotizaciones y operación comercial inicial.', 15000.00, 10.00, 162000.00, 30, 1, 0, 0, 1, 'Inicial', 'Ideal para comenzar con operación comercial ordenada.', '#3b82f6', 2, 0, 'Plan inicial con alcance controlado.', 'activo', 'BASICO_MENSUAL', 'BASICO_ANUAL', 1, '2026-04-11 02:06:31', 0, 3, '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(2, 'Profesional', 'profesional', 'Plan recomendado para escalar ventas con inventario y control comercial.', 26000.00, 10.00, 280800.00, 30, 1, 1, 1, 2, 'Más elegido', 'Incluye inventario completo, seguimiento y analítica base.', '#0ea5a4', 8, 0, 'Plan recomendado para la mayoría de empresas.', 'activo', 'PROFESIONAL_MENSUAL', 'PROFESIONAL_ANUAL', 1, '2026-04-08 03:49:24', 0, 3, '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL),
(3, 'Empresa', 'empresa', 'Plan avanzado para operación integral con mayor capacidad y control.', 55000.00, 15.00, 561000.00, 30, 1, 1, 0, 3, 'Escalable', 'Acceso completo a módulos y operación multiusuario.', '#7c3aed', 0, 1, 'Plan corporativo con usuarios ilimitados.', 'activo', 'EMPRESA_MENSUAL', 'EMPRESA_ANUAL', 1, '2026-04-07 20:27:56', 0, 3, '2026-04-07 01:23:58', '2026-04-14 00:45:18', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan_funcionalidades`
--

CREATE TABLE `plan_funcionalidades` (
  `id` bigint UNSIGNED NOT NULL,
  `plan_id` bigint UNSIGNED NOT NULL,
  `funcionalidad_id` bigint UNSIGNED NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `valor_numerico` int NOT NULL DEFAULT '0',
  `es_ilimitado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `plan_funcionalidades`
--

INSERT INTO `plan_funcionalidades` (`id`, `plan_id`, `funcionalidad_id`, `activo`, `valor_numerico`, `es_ilimitado`, `fecha_actualizacion`) VALUES
(1, 2, 10, 0, 0, 0, '2026-04-08 14:25:07'),
(2, 3, 10, 1, 0, 1, '2026-04-07 01:40:41'),
(3, 1, 10, 0, 0, 0, '2026-04-08 04:14:40'),
(4, 2, 6, 1, 0, 0, '2026-04-08 14:25:07'),
(5, 3, 6, 1, 0, 1, '2026-04-07 01:40:41'),
(6, 1, 6, 1, 0, 0, '2026-04-08 04:14:40'),
(7, 2, 5, 1, 0, 0, '2026-04-08 14:25:07'),
(8, 3, 5, 1, 0, 1, '2026-04-07 01:40:41'),
(9, 1, 5, 1, 0, 0, '2026-04-08 04:14:40'),
(10, 2, 7, 1, 0, 0, '2026-04-08 14:25:07'),
(11, 3, 7, 1, 0, 1, '2026-04-07 01:40:41'),
(12, 1, 7, 1, 0, 0, '2026-04-08 04:14:40'),
(13, 2, 2, 0, 0, 0, '2026-04-08 14:25:07'),
(14, 3, 2, 0, 0, 1, '2026-04-07 01:40:41'),
(15, 1, 2, 0, 0, 0, '2026-04-08 04:14:40'),
(16, 2, 4, 0, 0, 0, '2026-04-08 14:25:07'),
(17, 3, 4, 0, 0, 1, '2026-04-07 01:40:41'),
(18, 1, 4, 0, 0, 0, '2026-04-08 04:14:40'),
(19, 2, 3, 1, 0, 1, '2026-04-08 14:25:07'),
(20, 3, 3, 0, 0, 1, '2026-04-07 01:40:41'),
(21, 1, 3, 0, 0, 0, '2026-04-08 04:14:40'),
(22, 2, 1, 1, 0, 0, '2026-04-08 14:25:07'),
(23, 3, 1, 1, 0, 0, '2026-04-08 04:12:39'),
(24, 1, 1, 1, 2, 0, '2026-04-08 04:14:40'),
(25, 2, 18, 1, 0, 0, '2026-04-14 00:45:18'),
(26, 3, 18, 1, 0, 1, '2026-04-14 00:45:18'),
(27, 1, 18, 0, 0, 0, '2026-04-14 00:45:18'),
(28, 2, 12, 1, 0, 0, '2026-04-14 00:45:18'),
(29, 3, 12, 1, 0, 1, '2026-04-14 00:45:18'),
(30, 1, 12, 1, 0, 0, '2026-04-14 00:45:18'),
(31, 2, 14, 1, 0, 0, '2026-04-14 00:45:18'),
(32, 3, 14, 1, 0, 1, '2026-04-14 00:45:18'),
(33, 1, 14, 1, 0, 0, '2026-04-14 00:45:18'),
(34, 2, 16, 1, 0, 0, '2026-04-14 00:45:18'),
(35, 3, 16, 1, 0, 1, '2026-04-14 00:45:18'),
(36, 1, 16, 1, 0, 0, '2026-04-14 00:45:18'),
(37, 2, 22, 1, 0, 0, '2026-04-14 00:45:18'),
(38, 3, 22, 1, 0, 1, '2026-04-14 00:45:18'),
(39, 1, 22, 0, 0, 0, '2026-04-14 00:45:18'),
(40, 2, 19, 1, 0, 0, '2026-04-14 00:45:18'),
(41, 3, 19, 1, 0, 1, '2026-04-14 00:45:18'),
(42, 1, 19, 0, 0, 0, '2026-04-14 00:45:18'),
(43, 2, 23, 0, 0, 0, '2026-04-14 00:45:18'),
(44, 3, 23, 1, 0, 1, '2026-04-14 00:45:18'),
(45, 1, 23, 0, 0, 0, '2026-04-14 00:45:18'),
(46, 2, 15, 1, 0, 0, '2026-04-14 00:45:18'),
(47, 3, 15, 1, 0, 1, '2026-04-14 00:45:18'),
(48, 1, 15, 1, 0, 0, '2026-04-14 00:45:18'),
(49, 2, 13, 1, 0, 0, '2026-04-14 00:45:18'),
(50, 3, 13, 1, 0, 1, '2026-04-14 00:45:18'),
(51, 1, 13, 1, 0, 0, '2026-04-14 00:45:18'),
(52, 2, 17, 1, 0, 0, '2026-04-14 00:45:18'),
(53, 3, 17, 1, 0, 1, '2026-04-14 00:45:18'),
(54, 1, 17, 0, 0, 0, '2026-04-14 00:45:18'),
(55, 2, 21, 1, 0, 0, '2026-04-14 00:45:18'),
(56, 3, 21, 1, 0, 1, '2026-04-14 00:45:18'),
(57, 1, 21, 0, 0, 0, '2026-04-14 00:45:18'),
(58, 2, 24, 1, 0, 0, '2026-04-14 00:45:18'),
(59, 3, 24, 1, 0, 1, '2026-04-14 00:45:18'),
(60, 1, 24, 0, 0, 0, '2026-04-14 00:45:18'),
(61, 2, 20, 1, 0, 0, '2026-04-14 00:45:18'),
(62, 3, 20, 1, 0, 1, '2026-04-14 00:45:18'),
(63, 1, 20, 0, 0, 0, '2026-04-14 00:45:18'),
(64, 2, 9, 1, 0, 0, '2026-04-08 14:25:07'),
(65, 3, 9, 1, 0, 1, '2026-04-07 01:40:41'),
(66, 1, 9, 0, 0, 0, '2026-04-08 04:14:40'),
(67, 2, 8, 0, 0, 0, '2026-04-08 14:25:07'),
(68, 3, 8, 1, 0, 1, '2026-04-07 01:40:41'),
(69, 1, 8, 0, 0, 0, '2026-04-08 04:14:40'),
(70, 2, 11, 0, 0, 0, '2026-04-08 14:25:07'),
(71, 3, 11, 1, 0, 1, '2026-04-07 01:40:41'),
(72, 1, 11, 0, 0, 0, '2026-04-08 04:14:40'),
(152, 2, 36, 1, 0, 0, '2026-04-08 14:25:07'),
(153, 3, 36, 1, 0, 1, '2026-04-07 01:40:41'),
(154, 1, 36, 1, 0, 0, '2026-04-08 04:14:40'),
(155, 2, 34, 1, 0, 0, '2026-04-08 14:25:07'),
(156, 3, 34, 1, 0, 1, '2026-04-07 01:40:41'),
(157, 1, 34, 1, 0, 0, '2026-04-08 04:14:40'),
(158, 2, 35, 1, 0, 0, '2026-04-08 14:25:07'),
(159, 3, 35, 1, 0, 1, '2026-04-07 01:40:41'),
(160, 1, 35, 1, 0, 0, '2026-04-08 04:14:40'),
(161, 2, 28, 1, 0, 0, '2026-04-14 00:45:18'),
(162, 3, 28, 1, 0, 1, '2026-04-14 00:45:18'),
(163, 1, 28, 0, 0, 0, '2026-04-14 00:45:18'),
(164, 2, 26, 1, 0, 0, '2026-04-14 00:45:18'),
(165, 3, 26, 1, 0, 1, '2026-04-14 00:45:18'),
(166, 1, 26, 1, 0, 0, '2026-04-14 00:45:18'),
(167, 2, 30, 1, 0, 0, '2026-04-14 00:45:18'),
(168, 3, 30, 1, 0, 1, '2026-04-14 00:45:18'),
(169, 1, 30, 1, 0, 0, '2026-04-14 00:45:18'),
(170, 2, 25, 1, 0, 0, '2026-04-14 00:45:18'),
(171, 3, 25, 1, 0, 1, '2026-04-14 00:45:18'),
(172, 1, 25, 1, 0, 0, '2026-04-14 00:45:18'),
(173, 2, 31, 1, 0, 0, '2026-04-14 00:45:18'),
(174, 3, 31, 1, 0, 1, '2026-04-14 00:45:18'),
(175, 1, 31, 0, 0, 0, '2026-04-14 00:45:18'),
(176, 2, 29, 1, 0, 0, '2026-04-14 00:45:18'),
(177, 3, 29, 1, 0, 1, '2026-04-14 00:45:18'),
(178, 1, 29, 0, 0, 0, '2026-04-14 00:45:18'),
(179, 2, 33, 1, 0, 0, '2026-04-14 00:45:18'),
(180, 3, 33, 1, 0, 1, '2026-04-14 00:45:18'),
(181, 1, 33, 0, 0, 0, '2026-04-14 00:45:18'),
(182, 2, 32, 1, 0, 0, '2026-04-14 00:45:18'),
(183, 3, 32, 1, 0, 1, '2026-04-14 00:45:18'),
(184, 1, 32, 0, 0, 0, '2026-04-14 00:45:18'),
(185, 2, 27, 1, 0, 0, '2026-04-14 00:45:18'),
(186, 3, 27, 1, 0, 1, '2026-04-14 00:45:18'),
(187, 1, 27, 0, 0, 0, '2026-04-14 00:45:18'),
(480, 2, 37, 1, 0, 0, '2026-04-14 00:45:41'),
(481, 3, 37, 1, 0, 1, '2026-04-14 00:45:41'),
(482, 1, 37, 1, 0, 0, '2026-04-14 00:45:41'),
(483, 2, 38, 1, 0, 0, '2026-04-14 00:45:27'),
(484, 3, 38, 1, 0, 1, '2026-04-14 00:45:27'),
(485, 1, 38, 1, 0, 0, '2026-04-14 00:45:27'),
(492, 2, 62, 1, 0, 0, '2026-04-15 15:22:10'),
(493, 3, 62, 1, 0, 1, '2026-04-15 15:22:10'),
(494, 1, 62, 1, 0, 0, '2026-04-15 15:22:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `categoria_id` bigint UNSIGNED DEFAULT NULL,
  `tipo` enum('producto','servicio') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'producto',
  `codigo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `codigo_barras` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `unidad` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio` decimal(12,2) NOT NULL DEFAULT '0.00',
  `precio_oferta` decimal(12,2) NOT NULL DEFAULT '0.00',
  `costo` decimal(12,2) NOT NULL DEFAULT '0.00',
  `impuesto` decimal(8,2) NOT NULL DEFAULT '0.00',
  `descuento_maximo` decimal(8,2) NOT NULL DEFAULT '0.00',
  `stock_minimo` decimal(12,2) NOT NULL DEFAULT '0.00',
  `stock_critico` decimal(12,2) NOT NULL DEFAULT '0.00',
  `ultimo_aviso_stock_bajo` datetime DEFAULT NULL,
  `ultimo_aviso_stock_critico` datetime DEFAULT NULL,
  `stock_aviso` decimal(12,2) NOT NULL DEFAULT '0.00',
  `stock_actual` decimal(12,2) NOT NULL DEFAULT '0.00',
  `estado` enum('activo','inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `mostrar_catalogo` tinyint(1) NOT NULL DEFAULT '0',
  `destacado_catalogo` tinyint(1) NOT NULL DEFAULT '0',
  `proximo_catalogo` tinyint(1) NOT NULL DEFAULT '0',
  `proximo_dias_catalogo` int NOT NULL DEFAULT '0',
  `imagen_catalogo_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `empresa_id`, `categoria_id`, `tipo`, `codigo`, `sku`, `codigo_barras`, `nombre`, `descripcion`, `unidad`, `precio`, `precio_oferta`, `costo`, `impuesto`, `descuento_maximo`, `stock_minimo`, `stock_critico`, `ultimo_aviso_stock_bajo`, `ultimo_aviso_stock_critico`, `stock_aviso`, `stock_actual`, `estado`, `mostrar_catalogo`, `destacado_catalogo`, `proximo_catalogo`, `proximo_dias_catalogo`, `imagen_catalogo_url`, `fecha_creacion`, `fecha_actualizacion`, `fecha_eliminacion`) VALUES
(1, 69, 1, 'producto', 'LAP-ZEN-01', 'ZNT-14P-2026', '7801234567890', 'Laptop Zenit v14 Pro', 'CPU Quad-Core, 16GB RAM, SSD 512GB. Pantalla 14\" FHD.', 'unidad', 870000.00, 0.00, 650000.00, 19.00, 15.00, 5.00, 2.00, NULL, NULL, 2.00, 12.00, 'activo', 1, 0, 0, 0, '', '2026-04-08 14:25:36', '2026-04-14 21:17:19', NULL),
(2, 69, 2, 'producto', 'CPU-VOLT-V8', 'VX-8800K-X', '7801112223334', 'Procesador Core-X V8', '8 núcleos, 16 hilos, Frecuencia 4.2GHz. Socket AM4/LGA.', 'unidad', 285000.00, 0.00, 195000.00, 19.00, 10.00, 10.00, 4.00, NULL, NULL, 4.00, 33.00, 'activo', 1, 0, 0, 0, '', '2026-04-08 14:27:12', '2026-04-14 21:11:41', NULL),
(3, 69, 3, 'producto', 'MON-OPT-27', 'VV-27-4K-IPS', '7800001112223', 'Monitor Vision-View 27\"', 'Panel IPS 4K, 144Hz, bordes ultradelgados.', 'unidad', 215000.00, 0.00, 145000.00, 19.00, 15.00, 12.00, 5.00, NULL, NULL, 5.00, 29.00, 'activo', 1, 0, 0, 0, '', '2026-04-08 14:28:05', '2026-04-14 21:05:46', NULL),
(4, 69, 4, 'producto', 'NET-W6-MSH', 'NG-WIFI6-X2', '7805556667778', 'Router Mesh Omni-Link W6', 'Sistema Wi-Fi 6 malla, cobertura 250m2.', 'unidad', 145000.00, 0.00, 88000.00, 19.00, 10.00, 10.00, 4.00, NULL, NULL, 4.00, 16.00, 'activo', 1, 0, 0, 0, '', '2026-04-08 14:29:03', '2026-04-14 21:03:11', NULL),
(5, 69, 5, 'producto', 'SSD-STE-1TB', 'ST-EXT-1000', '7801234599999', 'Disco SSD Externo Terra-S Stellar', 'Unidad SSD portátil 1TB, conexión USB-C 3.2, resistente a golpes.', 'unidad', 110000.00, 0.00, 65000.00, 19.00, 25.00, 5.00, 3.00, NULL, NULL, 3.00, 16.00, 'activo', 1, 0, 0, 0, '', '2026-04-08 14:31:14', '2026-04-14 20:59:47', NULL),
(6, 69, 6, 'servicio', 'SRV-MANT-01', 'MANT-PREV-GEN', '', 'Plan de Mantenimiento Preventivo', 'Limpieza física profunda, lubricación de ventiladores, cambio de pasta térmica de alto rendimiento y optimización lógica del sistema operativo para extender la vida útil del equipo.', 'servicio', 35000.00, 0.00, 10000.00, 19.00, 25.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00, 'activo', 1, 0, 0, 0, '', '2026-04-08 14:33:11', '2026-04-14 20:56:39', NULL),
(7, 69, 7, 'servicio', 'SRV-CONS-101', 'AUDIT-CYBER-SEC', '', 'Auditoría de Ciberseguridad Inicial', 'Evaluación exhaustiva de vulnerabilidades en la red local, revisión de políticas de contraseñas y reporte de recomendaciones para la protección de datos sensibles de la empresa.', 'hora', 65000.00, 0.00, 25000.00, 19.00, 15.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00, 'activo', 1, 0, 0, 0, '', '2026-04-08 14:34:04', '2026-04-14 20:55:10', NULL),
(8, 73, 8, 'producto', '01245', '', '', 'cuadernos universitarios', '7mm', 'unidad', 2500.00, 0.00, 1250.00, 19.00, 0.00, 100.00, 50.00, NULL, NULL, 50.00, 277.00, 'activo', 1, 0, 0, 0, '', '2026-04-11 11:30:21', '2026-04-14 01:15:10', NULL),
(9, 73, 9, 'producto', 'c123', '', '', 'cargador telefono', '', 'unidad', 6500.00, 0.00, 2600.00, 19.00, 0.00, 50.00, 25.00, NULL, NULL, 25.00, 122.00, 'activo', 1, 0, 0, 0, '', '2026-04-11 11:44:57', '2026-04-14 01:13:22', NULL),
(10, 73, NULL, 'producto', '1234', '', '', 'ropa de cama', 'sabanas de 1 1/2', 'unidad', 21000.00, 0.00, 12000.00, 19.00, 0.00, 60.00, 20.00, NULL, NULL, 20.00, 80.00, 'activo', 0, 0, 0, 0, NULL, '2026-04-11 13:16:36', NULL, '2026-04-11 13:26:01'),
(11, 73, NULL, 'producto', '2321', '', '', 'plumon de cama 2 plazas', 'plumon cama 1 1/2', 'unidad', 18000.00, 0.00, 7800.00, 19.00, 0.00, 70.00, 20.00, NULL, NULL, 20.00, 74.00, 'activo', 1, 0, 0, 0, '', '2026-04-11 13:18:17', '2026-04-14 01:12:38', NULL),
(12, 73, 12, 'producto', '023', '', '', 'sabanas 1 1/2', 'sabanas de 1 1/2', 'unidad', 18000.00, 0.00, 7500.00, 19.00, 0.00, 70.00, 20.00, NULL, NULL, 20.00, 95.00, 'activo', 1, 0, 0, 0, '', '2026-04-11 13:26:55', '2026-04-14 01:12:24', NULL),
(13, 73, 15, 'producto', '124', '', '', 'ropa de niño', 'buzo de niño', 'unidad', 15900.00, 0.00, 5600.00, 19.00, 0.00, 80.00, 30.00, NULL, NULL, 30.00, 87.99, 'activo', 1, 0, 0, 0, '', '2026-04-11 14:29:35', '2026-04-14 01:10:34', NULL),
(20, 73, NULL, 'producto', '545641', '', '', 'Mesa de comedor 6 personas', '', 'unidad', 300000.00, 0.00, 100000.00, 19.00, 0.00, 20.00, 5.00, NULL, NULL, 5.00, 30.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 01:16:55', NULL, NULL),
(21, 77, 26, 'producto', '6922717299444', '', '6922717299444', 'Reactor Tornado V5 40+ Rojo', 'La Reactor Tornado V5 40+ Roja es una goma ofensiva moderna diseñada para adaptarse al juego actual con pelotas plásticas 40+. Ofrece un excelente equilibrio entre control, efecto y velocidad, siendo ideal para jugadores que buscan consistencia sin perder potencia en sus ataques.', 'unidad', 13000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 8.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 15:47:20', '2026-04-16 15:42:46', NULL),
(22, 77, 26, 'producto', '6922717299444', '', '6922717299444', 'Reactor Tornado V5 40+ Negro', 'La Reactor Tornado V5 40+ es una goma ofensiva moderna diseñada para adaptarse al juego actual con pelotas plásticas 40+. Ofrece un excelente equilibrio entre control, efecto y velocidad, siendo ideal para jugadores que buscan consistencia sin perder potencia en sus ataques.', 'unidad', 13000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 8.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 15:51:05', '2026-04-18 19:01:49', NULL),
(23, 77, 26, 'producto', '6971779532198', '', '6971779532198', 'Loki Rexton 3 Negro', 'Superficie pegajosa (sticky / tacky) Tiene una capa superior que “agarra” la pelota como si tuviera imán, ideal para generar mucho efecto (spin) en saques y topspin. Velocidad media No es una goma extremadamente rápida. Más bien ofrece un equilibrio entre control y ataque, lo que la hace buena para aprender técnica. Alto control Permite colocar la pelota con precisión. Perfecta si estás desarrollando consistencia. Esponja media a media-dura Esto ayuda a que la pelota “salga con intención”, pero sin perder sensibilidad. Estilo de juego recomendado Ataque con topspin Juego cercano a la mesa Jugadores en nivel principiante a intermedio', 'unidad', 17000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 4.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 16:08:38', '2026-04-16 15:46:00', NULL),
(24, 77, 26, 'producto', '6971779532198', '', '6971779532198', 'Loki Rexton 3 Rojo', 'Superficie pegajosa (sticky / tacky) Tiene una capa superior que “agarra” la pelota como si tuviera imán, ideal para generar mucho efecto (spin) en saques y topspin. Velocidad media No es una goma extremadamente rápida. Más bien ofrece un equilibrio entre control y ataque, lo que la hace buena para aprender técnica. Alto control Permite colocar la pelota con precisión. Perfecta si estás desarrollando consistencia. Esponja media a media-dura Esto ayuda a que la pelota “salga con intención”, pero sin perder sensibilidad. Estilo de juego recomendado Ataque con topspin Juego cercano a la mesa Jugadores en nivel principiante a intermedio', 'unidad', 17000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 3.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 16:18:05', '2026-04-16 15:46:41', NULL),
(25, 77, 26, 'producto', '6971779534598', '', '6971779534581', 'Loki Kirin K1 Rojo', 'Superficie no pegajosa (non-tacky) A diferencia de la Rexton 3, esta goma no es pegajosa, pero tiene alto agarre por fricción, lo que genera efecto de forma más “moderna” (tipo europeo) Alta velocidad con control Es bastante rápida, pero no incontrolable. Tiene un equilibrio muy bien logrado entre potencia y precisión Esponja Kunlun (media) Usa una esponja especial que da: buena elasticidad salida rápida de la pelota trayectorias largas y profundas Buen efecto sin pegajosidad Genera spin gracias a la elasticidad + fricción, no por “pegajosidad” como las gomas chinas clásicas Dureza media (~37°) Sensación equilibrada: ni muy dura ni muy blanda → buena para controlar y atacar', 'unidad', 17000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 2.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 16:31:52', '2026-04-16 22:35:02', NULL),
(26, 77, 26, 'producto', '6971779534581', '', '6971779534581', 'Loki Kirin K1 Negro', 'Superficie no pegajosa (non-tacky) A diferencia de la Rexton 3, esta goma no es pegajosa, pero tiene alto agarre por fricción, lo que genera efecto de forma más “moderna” (tipo europeo) Alta velocidad con control Es bastante rápida, pero no incontrolable. Tiene un equilibrio muy bien logrado entre potencia y precisión Esponja Kunlun (media) Usa una esponja especial que da: buena elasticidad salida rápida de la pelota trayectorias largas y profundas Buen efecto sin pegajosidad Genera spin gracias a la elasticidad + fricción, no por “pegajosidad” como las gomas chinas clásicas Dureza media (~37°) Sensación equilibrada: ni muy dura ni muy blanda → buena para controlar y atacar', 'unidad', 17000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 2.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 16:54:56', '2026-04-16 22:49:25', NULL),
(27, 77, 26, 'producto', '820969034279', '', '820969034279', 'Positive TUTTLE Ediciòn Asiática Morado', 'Superficie ligeramente pegajosa (semi-tacky) Tiene un toque pegajoso suave, típico de gomas asiáticas, lo que ayuda a generar buen efecto sin ser difícil de controlar. Velocidad media No es explosiva, pero sí lo suficientemente rápida para atacar. Está pensada más para consistencia que para potencia extrema. Alto control Su punto fuerte. Permite: colocar la pelota con precisión 🎯 hacer bloques seguros controlar el ritmo del juego Esponja media (suave-media) Sensación cómoda al golpear, con buen tiempo de contacto con la pelota (dwell time), lo que facilita el spin. Estilo asiático clásico Diseñada para un juego más técnico: topspin controlado juego cerca de la mesa aprendizaje de técnica correcta', 'unidad', 16000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 1.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 17:23:00', '2026-04-14 20:04:31', NULL),
(28, 77, 26, 'producto', '820969034279', '', '820969034279', 'Positive TUTTLE Ediciòn Asiática Verde', 'Superficie ligeramente pegajosa (semi-tacky) Tiene un toque pegajoso suave, típico de gomas asiáticas, lo que ayuda a generar buen efecto sin ser difícil de controlar. Velocidad media No es explosiva, pero sí lo suficientemente rápida para atacar. Está pensada más para consistencia que para potencia extrema. Alto control Su punto fuerte. Permite: colocar la pelota con precisión 🎯 hacer bloques seguros controlar el ritmo del juego Esponja media (suave-media) Sensación cómoda al golpear, con buen tiempo de contacto con la pelota (dwell time), lo que facilita el spin. Estilo asiático clásico Diseñada para un juego más técnico: topspin controlado juego cerca de la mesa aprendizaje de técnica correcta', 'unidad', 16000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 1.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 17:25:21', '2026-04-14 20:04:08', NULL),
(29, 77, 26, 'producto', '6971779534246', '', '6971779534246', 'Loki Rexton 5 Rojo', 'Superficie pegajosa (tacky) Tiene ese clásico “agarre chino” que permite: levantar backspin fácilmente generar mucho efecto en topspin y saques crear trayectorias curvas y difíciles de devolver Alta velocidad (ofensiva) Es bastante más rápida que la Rexton 3. Está diseñada para: golpes agresivos contraataques rápidos presión constante al rival Esponja dura de alta densidad Aquí está su “motor”: almacena energía al golpear la libera como efecto resorte (catapulta) da golpes muy potentes y profundos Dureza alta Sensación firme y sólida, ideal para golpes fuertes, pero exige buena técnica. Arco y spin avanzados Permite variar la trayectoria: loops con arco alto golpes rápidos más directos gran control del efecto en juego ofensivo', 'unidad', 19000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 1.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 17:38:47', '2026-04-14 20:03:47', NULL),
(30, 77, 26, 'producto', '6971779533966', '', '6971779533966', 'Loki T3 Carbono Rojo', 'Superficie no pegajosa (non-tacky) A diferencia de muchas gomas chinas clásicas, esta no es pegajosa. → Genera efecto por fricción y velocidad, no por “pegado” Esponja de carbono (carbon sponge) Su gran distintivo: mayor rigidez más potencia mejor estabilidad en golpes fuertes Velocidad alta (ofensiva) Es una goma rápida, ideal para: ataques directos contraataques rallies rápidos Dureza media-dura (~36°) Sensación firme pero no extrema, lo que permite: potencia sin perder completamente el control Buen control para su velocidad A pesar de ser ofensiva, mantiene un control bastante sólido, especialmente en bloqueos', 'unidad', 21000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 2.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 17:44:01', '2026-04-16 15:58:51', NULL),
(31, 77, 32, 'producto', '100000001', '', '100000001', 'Limpiador Rubber Cleaner', 'Elimina polvo y suciedad Durante el juego, la goma acumula: polvo sudor pelusas Todo eso reduce el efecto… y el cleaner lo soluciona 🧽 Recupera el agarre (spin) Una goma sucia pierde efecto. Al limpiarla: vuelve a generar más spin mejora el control Protege la goma Evita que se reseque o se desgaste rápidamente, alargando su vida útil.', 'unidad', 8000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 2.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 18:24:55', '2026-04-14 21:51:11', NULL),
(32, 77, 31, 'producto', '100000002', '', '100000001', 'Acelerante Haifu', 'Aumenta la velocidad La pelota sale más rápida y con mayor potencia. Mejora el efecto (spin) Permite generar topspin más pesado y con mejor curva. Más efecto catapulta La goma se siente más “viva”, como si tuviera resorte. Mayor sensación (feeling) Mejor contacto con la pelota, ideal para jugadores técnicos.', 'unidad', 30000.00, 24999.99, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 3.00, 'activo', 1, 0, 0, 8, '', '2026-04-14 18:33:47', '2026-04-17 16:36:26', NULL),
(33, 77, 27, 'producto', '6971779533454', '', '6971779533454', 'Madero Loki Kirin K2', 'El Kirin K2 ofrece un toque muy limpio y estable, con buena sensación de la pelota en cada golpe. La bola parece quedarse un instante más en la pala, lo que permite ajustar mejor el efecto y la dirección. Es ideal para quienes quieren construir el punto con paciencia, como si estuvieran dibujando cada golpe con precisión', 'unidad', 17000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 1.00, 'activo', 1, 0, 0, 19, '', '2026-04-14 20:30:44', '2026-04-16 20:53:57', NULL),
(34, 77, 27, 'producto', '6971779535168', '', '6971779535168', 'Loki Kirin K1 T', 'El Kirin K1 T destaca por su facilidad de uso, estabilidad en bloqueos y buen desempeño en topspin controlado, siendo una excelente opción para quienes buscan progresar en su nivel de juego sin perder control.', 'unidad', 15000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 1.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 20:38:51', NULL, NULL),
(35, 77, 27, 'producto', '6971779533270', '', '6971779533270', 'Loki Kirin K1', 'El Kirin K1 es un madero diseñado para ofrecer equilibrio total entre control y velocidad, ideal para quienes quieren dominar el ritmo del juego sin perder sensibilidad.', 'unidad', 15000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 1.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 20:44:16', '2026-04-16 20:53:39', NULL),
(36, 77, 27, 'producto', '1000000004', '', '1000000004', 'Madero Enginner Timber', 'Este madero está diseñado para ofrecer estabilidad, control y una sensación sólida, pensado para jugadores que valoran la precisión y la consistencia por encima del caos ofensivo.', 'unidad', 19000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 3.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 20:58:41', NULL, NULL),
(37, 77, 27, 'producto', '100000005', '', '100000005', 'Enginneer Timber Negro', 'Este madero está diseñado para ofrecer estabilidad, control y una sensación sólida, pensado para jugadores que valoran la precisión y la consistencia por encima del caos ofensivo.', 'unidad', 19000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 3.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 21:13:21', '2026-04-14 21:26:09', NULL),
(38, 77, 27, 'producto', '100000006', '', '100000006', 'Madero Boer Lion', 'Este madero está orientado a jugadores que quieren control con carácter ofensivo, un equilibrio donde la potencia aparece cuando se la pide, sin sacrificar estabilidad.', 'unidad', 17000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 1.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 21:17:49', '2026-04-16 20:53:13', NULL),
(39, 77, 30, 'producto', '100000007', '', '100000007', 'Polera Deportiva', 'Polera deportiva para entrena y competir', 'unidad', 15000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 9.00, 'activo', 0, 0, 0, 0, '', '2026-04-14 21:25:10', '2026-04-16 20:35:24', NULL),
(40, 77, 29, 'producto', '100000008', '', '100000008', 'Pelotas Sanwei RS40 100U', 'Las pelotas Sanwei son una opción confiable y accesible, pensadas tanto para entrenamientos como para competencias amateur. Fabricadas con material plástico ABS, ofrecen buena durabilidad, rebote uniforme y un vuelo bastante estable, lo que las convierte en una elección sólida para sesiones intensas sin gastar de más.', 'unidad', 25000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 1.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 21:35:54', '2026-04-16 20:53:02', NULL),
(41, 77, 28, 'producto', '100000009', '', '100000009', 'Estuche Sanwei', 'Es un estuche diseñado para guardar y proteger tu paleta de tenis de mesa, evitando daños, suciedad y desgaste.', 'unidad', 15000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 1.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 21:43:45', '2026-04-16 20:52:48', NULL),
(42, 77, 28, 'producto', '100000010', '', '100000010', 'Estuche Loki Dragon', 'Es un estuche diseñado para guardar y proteger tu paleta de tenis de mesa, evitando daños, suciedad y desgaste.', 'unidad', 15000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 1.00, 'activo', 1, 0, 0, 0, '', '2026-04-14 21:46:10', '2026-04-16 20:52:32', NULL),
(43, 69, 5, 'producto', 'ALM-TG2', 'SKU-0002', '7801234560021', 'Pendrive Titan-Gate 2TB', 'Memoria USB 3.2 de alta velocidad con carcasa de zinc resistente a golpes y agua.', 'unidad', 45990.00, 39990.00, 22000.00, 19.00, 15.00, 10.00, 5.00, NULL, NULL, 5.00, 25.00, 'activo', 1, 1, 0, 0, '', '2026-04-15 01:03:43', NULL, NULL),
(44, 69, 4, 'producto', 'RED-CL16', 'SKU-0034', '7801234560038', 'Switch Industrial Core-Link 16P', 'Switch administrable de 16 puertos Gigabit PoE+ para montaje en rack.', 'unidad', 120000.00, 115000.00, 89000.00, 19.00, 10.00, 3.00, 1.00, NULL, NULL, 1.00, 8.00, 'activo', 1, 1, 0, 0, '', '2026-04-15 01:06:23', NULL, NULL),
(45, 69, 3, 'producto', 'PER-ACRGB', 'SKU-0056', '7801234560045', 'Teclado Mecánico Aura-Click RGB', 'Teclado formato 60% con switches brown y retroiluminación personalizada.', 'unidad', 55000.00, 49990.00, 38000.00, 19.00, 20.00, 15.00, 5.00, NULL, NULL, 5.00, 40.00, 'activo', 1, 1, 0, 0, '', '2026-04-15 01:09:04', NULL, NULL),
(46, 69, 2, 'producto', 'HW-NE850', 'SKU-0077', '7801234560052', 'Fuente de Poder Nova-Energy 850W Gold', 'Fuente modular con certificación 80 Plus Gold y ventilador ultra silencioso.', 'unidad', 95000.00, 92990.00, 69990.00, 19.00, 10.00, 5.00, 2.00, NULL, NULL, 2.00, 12.00, 'activo', 1, 1, 0, 0, '', '2026-04-15 01:12:43', NULL, NULL),
(47, 69, 1, 'producto', 'COMP-OTX11', 'SKU-0036', '7801234560069', 'Tablet Orion Tab-X 11\"', 'Tablet de alto rendimiento con pantalla OLED y lápiz inteligente incluido.', 'unidad', 329990.00, 309990.00, 200000.00, 19.00, 15.00, 7.00, 5.00, NULL, NULL, 5.00, 15.00, 'activo', 1, 1, 0, 0, '', '2026-04-15 01:15:18', NULL, NULL),
(48, 77, 31, 'producto', '100000011', '', '100000011', 'PRODUCTO DE PRUEBA', 'PRODUCTO DE PRUEBA', 'unidad', 500.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 1.00, 'activo', 1, 1, 0, 0, '', '2026-04-15 14:38:35', '2026-04-15 16:07:45', '2026-04-16 15:07:40'),
(49, 77, 26, 'producto', '100000012', '', '100000012', 'Telson 100 Negra', 'La Telson 100 es una goma ofensiva no pegajosa (non-sticky) diseñada para jugadores que buscan velocidad alta con buen control. Es ideal para un estilo moderno de ataque, especialmente para topspin y golpes potentes.', 'unidad', 31000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 0.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 20:48:53', '2026-04-16 20:59:18', NULL),
(50, 77, 26, 'producto', '100000012', '', '100000012', 'Telson 100 Rojo', 'Superficie no pegajosa (non-tacky) A diferencia de la Rexton 3, esta goma no es pegajosa, pero tiene alto agarre por fricción, lo que genera efecto de forma más “moderna” (tipo europeo) Alta velocidad con control Es bastante rápida, pero no incontrolable. Tiene un equilibrio muy bien logrado entre potencia y precisión Esponja Kunlun (media) Usa una esponja especial que da: buena elasticidad salida rápida de la pelota trayectorias largas y profundas Buen efecto sin pegajosidad Genera spin gracias a la elasticidad + fricción, no por “pegajosidad” como las gomas chinas clásicas Dureza media (~37°) Sensación equilibrada: ni muy dura ni muy blanda → buena para controlar y atacar', 'unidad', 31000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 20:52:16', NULL, NULL),
(51, 77, 26, 'producto', '100000013', '', '100000013', 'Loki Kirin k5 Negro', 'La Kirin K5 es una goma pensada para jugadores que buscan un equilibrio entre control, efecto y velocidad, siendo una opción muy buena para aprender y mejorar el juego ofensivo sin perder estabilidad.', 'unidad', 22000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 21:09:54', '2026-04-16 21:12:10', NULL),
(52, 77, 26, 'producto', '100000014', '', '100000014', 'Loki Rexton 9 Rojo', 'La Rxton 9 es una goma ofensiva moderna, pensada para jugadores que buscan velocidad alta, buen spin y sensación firme, con un estilo más agresivo que las Rxton básicas.', 'unidad', 31000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 21:26:10', NULL, NULL),
(53, 77, 26, 'producto', '100000015', '', '100000015', 'Loki Rexton 7 Nacional Negro', 'La Rxton 7 es una goma ofensiva de alto rendimiento dentro de la serie Rxton, pensada para jugadores que quieren más velocidad y potencia que las versiones básicas, sin perder totalmente el control.', 'unidad', 28000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 21:31:36', NULL, NULL),
(54, 77, 26, 'producto', '100000014', '', '100000014', 'Loki Rexton 9 Negro', 'La Rxton 9 es una goma ofensiva moderna, pensada para jugadores que buscan velocidad alta, buen spin y sensación firme, con un estilo más agresivo que las Rxton básicas.', 'unidad', 31000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 21:33:40', '2026-04-16 21:34:40', NULL),
(55, 77, 26, 'producto', '100000015', '', '100000015', 'Loki Rexton 7 Nacional Rojo', 'La Rxton 7 es una goma ofensiva de alto rendimiento dentro de la serie Rxton, pensada para jugadores que quieren más velocidad y potencia que las versiones básicas, sin perder totalmente el control.', 'unidad', 28000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 21:37:13', NULL, NULL),
(56, 77, 26, 'producto', '100000013', '', '100000013', 'Loki Kirin K5 Rojo', 'La Kirin K5 es una goma pensada para jugadores que buscan un equilibrio entre control, efecto y velocidad, siendo una opción muy buena para aprender y mejorar el juego ofensivo sin perder estabilidad.', 'unidad', 22000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 21:40:19', NULL, NULL),
(57, 77, 27, 'producto', '100000016', '', '100000016', 'Loki Monster M6 PRO FL', 'El Monster M6 Pro es un madero ofensivo de 7 capas (todo madera), diseñado para jugadores que quieren pegar fuerte, pero sin perder el control como si estuvieran domando una bestia.', 'unidad', 34000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 21:55:31', '2026-04-16 22:03:23', NULL),
(58, 77, 27, 'producto', '100000017', '', '100000017', 'Loki Monster M6 PRO CS', 'Un madero que se siente como una espada bien equilibrada: ni demasiado salvaje, ni demasiado dócil… justo donde quieres que esté.', 'unidad', 34000.00, 0.00, 0.00, 19.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 22:03:08', NULL, NULL),
(59, 77, 27, 'producto', '100000018', '', '100000018', 'Loki Arthur W81 PRO FL', 'El Arthur W81 PRO no es un madero que pide permiso… entra a la mesa como un golpe seco y decidido. Si te gusta atacar sin dudar y sentir la pelota salir disparada, este madero te va a encantar', 'unidad', 68000.00, 0.00, 0.00, 19.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 22:15:09', NULL, NULL),
(60, 77, 27, 'producto', '100000018', '', '100000018', 'Loki Arthur W81 PRO CS', 'El Arthur W81 PRO no es un madero que pide permiso… entra a la mesa como un golpe seco y decidido. Si te gusta atacar sin dudar y sentir la pelota salir disparada, este madero te va a encantar', 'unidad', 68000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 22:17:11', '2026-04-16 22:17:26', NULL),
(61, 77, 27, 'producto', '100000019', '', '100000019', 'Loki Telson CNF FL', 'El Telson CNF FL es como un motor turbo con volante preciso: acelera fuerte, pero no se descontrola. Te da velocidad… pero también te deja sentir cada golpe con claridad', 'unidad', 77000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 22:22:21', NULL, NULL),
(62, 77, 27, 'producto', '100000019', '', '100000019', 'Loki Telson CNF CS', 'El Telson CNF FL es como un motor turbo con volante preciso: acelera fuerte, pero no se descontrola. Te da velocidad… pero también te deja sentir cada golpe con claridad', 'unidad', 77000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 22:23:55', NULL, NULL),
(63, 77, 27, 'producto', '100000020', '', '100000020', 'Sanwei ALC Interior De Prisma', 'La fibra de carbono está más cerca del núcleo, no justo bajo la capa externa. Resultado: sensación más suave, controlada y con mayor “dwell time” (la pelota se queda un microsegundo más pegada).', 'unidad', 63000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 22:29:03', NULL, NULL),
(64, 77, 27, 'producto', '100000021', '', '100000021', 'Victas Swat Swat 5PW FL', 'La SWAT 5PW es ese jugador silencioso que no hace show… pero gana puntos igual, uno tras otro, como un metrónomo con hambre de victoria', 'unidad', 75000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 22:37:49', NULL, NULL),
(65, 77, 27, 'producto', '100000021', '', '100000021', 'Victas Swat Swat 5PW CS', 'La SWAT 5PW es ese jugador silencioso que no hace show… pero gana puntos igual, uno tras otro, como un metrónomo con hambre de victoria', 'unidad', 75000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 22:40:51', NULL, NULL),
(66, 77, 27, 'producto', '100000021', '', '100000021', 'Victas Swat Swat 5PW ST', 'La SWAT 5PW es ese jugador silencioso que no hace show… pero gana puntos igual, uno tras otro, como un metrónomo con hambre de victoria', 'unidad', 75000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 22:43:06', NULL, NULL),
(67, 77, 27, 'producto', '100000022', '', '100000022', 'GEWO Power Allround FL', 'Estás empezando o en nivel intermedio Quieres mejorar técnica y consistencia Te gusta variar entre ataque, control y defensa Buscas precisión antes que potencia bruta', 'unidad', 56000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 10, '', '2026-04-16 22:49:37', NULL, NULL),
(68, 77, 26, 'producto', '100000023', '', '100000023', 'Loki Arthur Pink', 'Estás en nivel principiante avanzado o intermedio Juegas con loops, control y colocación Quieres una goma cómoda para revés o derecho controlado', 'unidad', 24000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 22:57:26', '2026-04-16 23:01:47', NULL),
(69, 77, 26, 'producto', '100000023', '', '100000023', 'Loki Arthur Blue', 'Estás en nivel principiante avanzado o intermedio Juegas con loops, control y colocación Quieres una goma cómoda para revés o derecho controlado', 'unidad', 24000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 11.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 22:58:51', '2026-04-18 19:04:27', NULL),
(70, 77, 26, 'producto', '100000023', '', '100000023', 'Loki Arthur Green', 'Estás en nivel principiante avanzado o intermedio Juegas con loops, control y colocación Quieres una goma cómoda para revés o derecho controlado', 'unidad', 24000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 19.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 23:00:48', '2026-04-16 23:16:52', NULL),
(71, 77, 29, 'producto', '100000024', '', '100000024', 'Pelotas Blancas Huieson 100U', 'Un pack grande de 100 pelotas blancas de tenis de mesa, diseñadas principalmente para práctica intensiva, multibolas y entrenamientos largos.', 'unidad', 20000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-16 23:15:58', NULL, NULL),
(72, 77, 27, 'producto', '100000025', '', '100000025', 'Loki Kirin K3', 'Control alto: perfecto para colocar la pelota donde quieres Velocidad moderada: no es rápido, pero suficiente para atacar cuando toca Sensación suave: facilita aprender golpes como topspin y bloqueo Estabilidad: muy cómodo para juego consistente', 'unidad', 18000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 9, '', '2026-04-18 14:04:39', NULL, NULL),
(73, 77, 27, 'producto', '100000026', '', '100000026', 'Loki Kirin K9', 'Alta velocidad: ideal para ataques y topspin agresivo Buen control para su categoría: no es salvaje, pero exige técnica Sensación firme: golpe más directo y potente Respuesta explosiva: la pelota sale con decisión', 'unidad', 27000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 10, '', '2026-04-18 14:09:53', NULL, NULL),
(74, 77, 33, 'producto', '100000027', '', '100000027', 'YINHE Urano Pro Rojo', 'La Uranus Pro es una goma de poros cortos (pips-out) diseñada para un juego ofensivo rápido y directo. Tiene una esponja suave-media con efecto tensor, lo que le da un rebote ágil y una salida de bola muy rápida.', 'unidad', 22000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 10, '', '2026-04-18 14:24:52', NULL, NULL),
(75, 77, 27, 'producto', '100000028', '', '100000028', 'Loki Rexton Pro FL', 'Construcción: 7 capas (normalmente madera + carbono) Estilo: OFF / OFF+ Sensación: rígida, directa, con poca flexión Velocidad: alta. Control: medio (no es para manos temblorosas) Peso: medio-alto', 'unidad', 30000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-18 15:30:05', NULL, NULL),
(76, 77, 27, 'producto', '100000028', '', '100000028', 'Loki Rexton 5 Pro CS', 'Construcción: 7 capas (normalmente madera + carbono) Estilo: OFF / OFF+ Sensación: rígida, directa, con poca flexión Velocidad: alta. Control: medio (no es para manos temblorosas) Peso: medio-alto', 'unidad', 30000.00, 0.00, 0.00, 19.00, 0.00, 3.00, 2.00, NULL, NULL, 2.00, 20.00, 'activo', 1, 0, 1, 11, '', '2026-04-18 15:31:57', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_imagenes`
--

CREATE TABLE `productos_imagenes` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `ruta` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `es_principal` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `productos_imagenes`
--

INSERT INTO `productos_imagenes` (`id`, `empresa_id`, `producto_id`, `ruta`, `es_principal`, `fecha_creacion`) VALUES
(1, 73, 13, '/uploads/productos_catalogo/73/prod_13_f4007853a8b2.jpg', 1, '2026-04-14 01:09:06'),
(2, 73, 13, '/uploads/productos_catalogo/73/prod_13_c363a36daa1d.png', 0, '2026-04-14 01:09:34'),
(3, 73, 12, '/uploads/productos_catalogo/73/prod_12_c95ecf78de03.png', 1, '2026-04-14 01:11:01'),
(4, 73, 11, '/uploads/productos_catalogo/73/prod_11_4bfe7c3ac651.png', 1, '2026-04-14 01:11:27'),
(5, 73, 9, '/uploads/productos_catalogo/73/prod_9_2dfc110903dd.png', 1, '2026-04-14 01:13:04'),
(6, 73, 8, '/uploads/productos_catalogo/73/prod_8_83ecfadfae6d.png', 1, '2026-04-14 01:13:49'),
(7, 73, 8, '/uploads/productos_catalogo/73/prod_8_a0dc16f27bf5.png', 0, '2026-04-14 01:14:34'),
(8, 73, 8, '/uploads/productos_catalogo/73/prod_8_43e47e037979.png', 0, '2026-04-14 01:15:10'),
(9, 73, 20, '/uploads/productos_catalogo/73/prod_20_88f298864d7a.png', 1, '2026-04-14 01:16:55'),
(10, 77, 21, '/uploads/productos_catalogo/77/prod_21_2a5884200545.webp', 1, '2026-04-14 15:47:20'),
(13, 77, 21, '/uploads/productos_catalogo/77/prod_21_d6b4b208be30.jpg', 0, '2026-04-14 15:55:45'),
(14, 77, 23, '/uploads/productos_catalogo/77/prod_23_abe45d86c442.jpg', 1, '2026-04-14 16:08:38'),
(15, 77, 24, '/uploads/productos_catalogo/77/prod_24_b4032b9c4aa2.jpg', 1, '2026-04-14 16:18:05'),
(18, 77, 27, '/uploads/productos_catalogo/77/prod_27_390c486110b7.webp', 1, '2026-04-14 17:23:00'),
(19, 77, 28, '/uploads/productos_catalogo/77/prod_28_a0817b347f37.webp', 1, '2026-04-14 17:25:21'),
(20, 77, 29, '/uploads/productos_catalogo/77/prod_29_3d1d03b4f78f.webp', 1, '2026-04-14 17:38:47'),
(21, 77, 30, '/uploads/productos_catalogo/77/prod_30_929069812fe9.webp', 1, '2026-04-14 17:44:01'),
(22, 77, 29, '/uploads/productos_catalogo/77/prod_29_92f515d0074c.webp', 0, '2026-04-14 17:47:47'),
(25, 77, 32, '/uploads/productos_catalogo/77/prod_32_fe65738c27c3.jpg', 1, '2026-04-14 20:02:17'),
(26, 77, 30, '/uploads/productos_catalogo/77/prod_30_bdbff136f270.webp', 0, '2026-04-14 20:03:29'),
(27, 77, 29, '/uploads/productos_catalogo/77/prod_29_92802fde3414.webp', 0, '2026-04-14 20:03:47'),
(28, 77, 28, '/uploads/productos_catalogo/77/prod_28_16b8b4332614.webp', 0, '2026-04-14 20:04:08'),
(29, 77, 27, '/uploads/productos_catalogo/77/prod_27_9bd7681c4144.webp', 0, '2026-04-14 20:04:31'),
(30, 77, 26, '/uploads/productos_catalogo/77/prod_26_06959fedd26e.jpg', 1, '2026-04-14 20:04:51'),
(31, 77, 25, '/uploads/productos_catalogo/77/prod_25_37f3ca111878.jpg', 1, '2026-04-14 20:05:09'),
(32, 77, 24, '/uploads/productos_catalogo/77/prod_24_0f6027907f4c.jpg', 0, '2026-04-14 20:05:30'),
(33, 77, 23, '/uploads/productos_catalogo/77/prod_23_74817df4f7fc.jpg', 0, '2026-04-14 20:05:49'),
(34, 77, 22, '/uploads/productos_catalogo/77/prod_22_8d7fc3ca5f3c.jpg', 0, '2026-04-14 20:06:14'),
(35, 77, 21, '/uploads/productos_catalogo/77/prod_21_e2ecfbbd63f4.webp', 0, '2026-04-14 20:07:03'),
(39, 77, 33, '/uploads/productos_catalogo/77/prod_33_b2fd02afee1d.webp', 1, '2026-04-14 20:30:44'),
(40, 77, 34, '/uploads/productos_catalogo/77/prod_34_42da6dc8d3d1.jpg', 1, '2026-04-14 20:38:51'),
(42, 77, 35, '/uploads/productos_catalogo/77/prod_35_343afbcc95cb.webp', 1, '2026-04-14 20:52:11'),
(43, 77, 36, '/uploads/productos_catalogo/77/prod_36_4a1d94a9a23a.webp', 1, '2026-04-14 20:58:41'),
(44, 69, 5, '/uploads/productos_catalogo/69/prod_5_197955784f24.png', 1, '2026-04-14 20:59:47'),
(45, 69, 5, '/uploads/productos_catalogo/69/prod_5_b46e2781d0db.png', 0, '2026-04-14 20:59:47'),
(46, 69, 4, '/uploads/productos_catalogo/69/prod_4_e0278eac7557.png', 1, '2026-04-14 21:03:11'),
(47, 69, 4, '/uploads/productos_catalogo/69/prod_4_160520a9e748.png', 0, '2026-04-14 21:03:11'),
(48, 69, 3, '/uploads/productos_catalogo/69/prod_3_5db75dd6c7bd.png', 1, '2026-04-14 21:05:46'),
(49, 69, 3, '/uploads/productos_catalogo/69/prod_3_81da2393aa45.png', 0, '2026-04-14 21:05:46'),
(50, 69, 2, '/uploads/productos_catalogo/69/prod_2_11c6f1a7bfc4.png', 1, '2026-04-14 21:11:41'),
(51, 69, 2, '/uploads/productos_catalogo/69/prod_2_9d87c0dc67cb.png', 0, '2026-04-14 21:11:41'),
(52, 77, 37, '/uploads/productos_catalogo/77/prod_37_84dc6a33244e.jpg', 1, '2026-04-14 21:13:21'),
(53, 69, 1, '/uploads/productos_catalogo/69/prod_1_8102ad3475e3.png', 1, '2026-04-14 21:17:19'),
(54, 69, 1, '/uploads/productos_catalogo/69/prod_1_682715b82647.png', 0, '2026-04-14 21:17:19'),
(55, 77, 38, '/uploads/productos_catalogo/77/prod_38_68c9ca54d265.jpg', 1, '2026-04-14 21:17:49'),
(56, 77, 40, '/uploads/productos_catalogo/77/prod_40_72bf9751b1b4.png', 1, '2026-04-14 21:35:54'),
(57, 77, 41, '/uploads/productos_catalogo/77/prod_41_37fd3143619c.webp', 1, '2026-04-14 21:43:45'),
(58, 77, 41, '/uploads/productos_catalogo/77/prod_41_1d61d995c97f.jpg', 0, '2026-04-14 21:44:13'),
(59, 77, 42, '/uploads/productos_catalogo/77/prod_42_c88443755543.webp', 1, '2026-04-14 21:46:45'),
(60, 77, 42, '/uploads/productos_catalogo/77/prod_42_55b34ea21e66.jpg', 0, '2026-04-14 21:47:02'),
(61, 77, 31, '/uploads/productos_catalogo/77/prod_31_2f8f3eec8d1b.png', 1, '2026-04-14 21:50:02'),
(62, 77, 31, '/uploads/productos_catalogo/77/prod_31_2612a4a5a884.png', 0, '2026-04-14 21:51:11'),
(63, 77, 32, '/uploads/productos_catalogo/77/prod_32_5877c532d061.png', 0, '2026-04-14 22:19:49'),
(64, 69, 43, '/uploads/productos_catalogo/69/prod_43_df2513f0bee2.png', 1, '2026-04-15 01:03:43'),
(65, 69, 44, '/uploads/productos_catalogo/69/prod_44_1b30f947ee3f.png', 1, '2026-04-15 01:06:23'),
(66, 69, 45, '/uploads/productos_catalogo/69/prod_45_bee75528fa5f.png', 1, '2026-04-15 01:09:04'),
(67, 69, 46, '/uploads/productos_catalogo/69/prod_46_b3f93c49fee7.png', 1, '2026-04-15 01:12:43'),
(68, 69, 47, '/uploads/productos_catalogo/69/prod_47_436987787984.png', 1, '2026-04-15 01:15:18'),
(70, 77, 48, '/uploads/productos_catalogo/77/prod_48_04b83daf37e6.webp', 1, '2026-04-15 14:43:22'),
(71, 77, 23, '/uploads/productos_catalogo/77/prod_23_ae537ae8df38.png', 0, '2026-04-16 15:45:44'),
(72, 77, 24, '/uploads/productos_catalogo/77/prod_24_495e78cb8cd4.jpg', 0, '2026-04-16 15:46:41'),
(73, 77, 25, '/uploads/productos_catalogo/77/prod_25_bf8e56e9ec84.png', 0, '2026-04-16 15:55:17'),
(74, 77, 26, '/uploads/productos_catalogo/77/prod_26_fbee626deb3f.png', 0, '2026-04-16 15:55:47'),
(75, 77, 30, '/uploads/productos_catalogo/77/prod_30_329073ede145.png', 0, '2026-04-16 15:58:51'),
(78, 77, 50, '/uploads/productos_catalogo/77/prod_50_f118aae54d48.webp', 1, '2026-04-16 20:52:16'),
(79, 77, 49, '/uploads/productos_catalogo/77/prod_49_31bf7601dd1a.webp', 1, '2026-04-16 20:58:59'),
(80, 77, 49, '/uploads/productos_catalogo/77/prod_49_052f8b117810.jpg', 0, '2026-04-16 20:59:18'),
(81, 77, 51, '/uploads/productos_catalogo/77/prod_51_6f7db85949a6.png', 1, '2026-04-16 21:09:54'),
(82, 77, 52, '/uploads/productos_catalogo/77/prod_52_01d263fee637.png', 1, '2026-04-16 21:26:10'),
(83, 77, 53, '/uploads/productos_catalogo/77/prod_53_464ceb0ba159.png', 1, '2026-04-16 21:31:36'),
(84, 77, 54, '/uploads/productos_catalogo/77/prod_54_0675b64a9b69.png', 1, '2026-04-16 21:33:40'),
(85, 77, 55, '/uploads/productos_catalogo/77/prod_55_6be38de92d82.png', 1, '2026-04-16 21:37:13'),
(86, 77, 56, '/uploads/productos_catalogo/77/prod_56_f768344d20af.png', 1, '2026-04-16 21:40:19'),
(88, 77, 58, '/uploads/productos_catalogo/77/prod_58_e4707f31f9b7.png', 1, '2026-04-16 22:03:08'),
(89, 77, 57, '/uploads/productos_catalogo/77/prod_57_6f3c890241f2.png', 0, '2026-04-16 22:03:23'),
(90, 77, 59, '/uploads/productos_catalogo/77/prod_59_16456dac7d62.png', 1, '2026-04-16 22:15:09'),
(91, 77, 60, '/uploads/productos_catalogo/77/prod_60_c21c1ec1d195.png', 1, '2026-04-16 22:17:11'),
(92, 77, 61, '/uploads/productos_catalogo/77/prod_61_1d493885ab8a.png', 1, '2026-04-16 22:22:21'),
(93, 77, 62, '/uploads/productos_catalogo/77/prod_62_743122a89589.png', 1, '2026-04-16 22:23:55'),
(94, 77, 63, '/uploads/productos_catalogo/77/prod_63_addb5adea4fb.png', 1, '2026-04-16 22:29:03'),
(95, 77, 64, '/uploads/productos_catalogo/77/prod_64_c527438e60e5.png', 1, '2026-04-16 22:37:49'),
(96, 77, 65, '/uploads/productos_catalogo/77/prod_65_8ffc8d3051df.png', 1, '2026-04-16 22:40:51'),
(97, 77, 66, '/uploads/productos_catalogo/77/prod_66_d4e8d0523d3b.png', 1, '2026-04-16 22:43:06'),
(98, 77, 67, '/uploads/productos_catalogo/77/prod_67_27713aa12c30.png', 1, '2026-04-16 22:49:37'),
(99, 77, 68, '/uploads/productos_catalogo/77/prod_68_3e682b43d66f.png', 1, '2026-04-16 22:57:26'),
(100, 77, 69, '/uploads/productos_catalogo/77/prod_69_cee471296bee.png', 1, '2026-04-16 22:58:51'),
(101, 77, 70, '/uploads/productos_catalogo/77/prod_70_9ab2f3d0eb47.png', 1, '2026-04-16 23:00:48'),
(102, 77, 71, '/uploads/productos_catalogo/77/prod_71_1e672d4a6a92.png', 1, '2026-04-16 23:15:58'),
(103, 77, 72, '/uploads/productos_catalogo/77/prod_72_377c117aac04.webp', 1, '2026-04-18 14:04:40'),
(104, 77, 73, '/uploads/productos_catalogo/77/prod_73_5d56b3bc48e1.png', 1, '2026-04-18 14:09:53'),
(105, 77, 74, '/uploads/productos_catalogo/77/prod_74_ac46d86e75c8.png', 1, '2026-04-18 14:24:52'),
(106, 77, 75, '/uploads/productos_catalogo/77/prod_75_bb37502a519a.png', 1, '2026-04-18 15:30:05'),
(107, 77, 76, '/uploads/productos_catalogo/77/prod_76_8aca829f71d7.png', 1, '2026-04-18 15:31:57'),
(108, 77, 22, '/uploads/productos_catalogo/77/prod_22_13dd6a7ad4b1.jpg', 1, '2026-04-18 19:01:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores_inventario`
--

CREATE TABLE `proveedores_inventario` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identificador_fiscal` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contacto` varchar(140) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ciudad` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacion` text COLLATE utf8mb4_unicode_ci,
  `estado` enum('activo','inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedores_inventario`
--

INSERT INTO `proveedores_inventario` (`id`, `empresa_id`, `nombre`, `identificador_fiscal`, `contacto`, `correo`, `telefono`, `direccion`, `ciudad`, `observacion`, `estado`, `fecha_creacion`) VALUES
(1, 69, 'Importadora Tecnológica del Sur SpA', '76.890.432-1', 'Ricardo Lagos M.', 'javieraagonzalezmoeller@gmail.com', '+56 2 2456 7890', 'Av. Las Condes 12450, Oficina 402, Las Condes.', 'Santiago', 'Proveedor principal de componentes internos (CPU, GPU, RAM). Ofrece crédito a 30 días tras la cuarta compra.', 'activo', '2026-04-08 14:36:40'),
(2, 69, 'Distribuidora de Accesorios Globales Ltda', '77.123.555-K', 'Marcela Paz Valdés', 'contacto@globalclick.cl', '+56 9 8765 4321', 'Calle O\'Higgins 456, Local 12, Concepción.', 'Concepción', 'Especialistas en teclados, mouses y monitores de marcas internacionales. Despacho gratuito por compras sobre $500.000 netos.', 'activo', '2026-04-08 14:37:31'),
(3, 69, 'Soluciones de Conectividad Los Ángeles E.I.R.L.', '76.444.222-8', 'Esteban Quito S.', 'logistica@laredes.cl', '+56 43 232 1100', 'Av. Ricardo Vicuña 002, Los Ángeles, Biobío.', 'Los Ángeles', 'Proveedor local para cables de red, canaletas y racks. Útil para compras de emergencia por cercanía física.', 'activo', '2026-04-08 14:38:27'),
(4, 73, 'Razon Social Prueba tres', '22.222.222-2', 'nombre contacto prueba trece', 'proveedor@pruebatrece.cl', '+5645122561313', 'Roma 123', 'Arica', '', 'activo', '2026-04-11 11:26:47'),
(5, 73, 'Razon Social Prueba cuatro', '33.333.333-3', 'nombre de contacto prueba cuatro', 'proveedor@pruebacuatro.cl', '+5645122561313', 'Roma 123', 'valdivia', '', 'activo', '2026-04-11 13:06:37'),
(6, 73, 'Razon Social Prueba cinco', '10.100.100-1', 'nombre de contacto prueba cinco', 'proveedor@pruebacinco.cl', '+5645122561313', 'Roma 123', 'Osorno', '', 'activo', '2026-04-11 14:10:13'),
(7, 73, 'Cliente Prueba seis', '77.777.777-7', 'nombre contacto prueba seis', 'soledadmellazuniga@gmail.com', '+56965827533', 'Parma 1310', 'Los Angeles', '', 'activo', '2026-04-11 14:38:03'),
(8, 73, 'Razon social prueba seis', '77.777.777-7', 'nombre contacto prueba seis', 'soledadmellazuniga@gmail.com', '45122561313', 'Roma 123', 'Arica', '', 'activo', '2026-04-11 14:40:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recepciones_inventario`
--

CREATE TABLE `recepciones_inventario` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `proveedor_id` bigint UNSIGNED DEFAULT NULL,
  `orden_compra_id` bigint UNSIGNED DEFAULT NULL,
  `tipo_documento` enum('guia_despacho','factura') COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_documento` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_documento` date NOT NULL,
  `referencia_interna` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observacion` text COLLATE utf8mb4_unicode_ci,
  `usuario_id` bigint UNSIGNED DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `recepciones_inventario`
--

INSERT INTO `recepciones_inventario` (`id`, `empresa_id`, `proveedor_id`, `orden_compra_id`, `tipo_documento`, `numero_documento`, `fecha_documento`, `referencia_interna`, `observacion`, `usuario_id`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 69, 1, NULL, 'factura', '4520', '2026-04-08', 'OC-069-000001', 'Recepción conforme de hardware crítico. Se valida estado físico de los componentes.', 70, '2026-04-08 14:57:57', NULL),
(2, 69, 2, NULL, 'guia_despacho', '8821', '2026-04-08', 'OC-PERIF-001', 'Recepción de periféricos para stock de temporada. Se verifica integridad de empaques.', 70, '2026-04-08 15:38:06', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recepciones_inventario_detalle`
--

CREATE TABLE `recepciones_inventario_detalle` (
  `id` bigint UNSIGNED NOT NULL,
  `recepcion_id` bigint UNSIGNED NOT NULL,
  `producto_id` bigint UNSIGNED NOT NULL,
  `cantidad` decimal(12,2) NOT NULL,
  `costo_unitario` decimal(12,2) NOT NULL DEFAULT '0.00',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `recepciones_inventario_detalle`
--

INSERT INTO `recepciones_inventario_detalle` (`id`, `recepcion_id`, `producto_id`, `cantidad`, `costo_unitario`, `subtotal`) VALUES
(1, 1, 2, 10.00, 195000.00, 1950000.00),
(2, 2, 3, 12.00, 145000.00, 1740000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `restablecimientos_contrasena`
--

CREATE TABLE `restablecimientos_contrasena` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `token` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiracion` datetime NOT NULL,
  `usado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `codigo`, `fecha_creacion`) VALUES
(1, 'Superadministrador', 'superadministrador', '2026-04-07 01:23:58'),
(2, 'Administrador', 'administrador_empresa', '2026-04-07 01:23:58'),
(3, 'Vendedor', 'vendedor', '2026-04-07 01:23:58'),
(4, 'Administrativo', 'administrativo', '2026-04-07 01:23:58'),
(5, 'Contabilidad', 'contabilidad', '2026-04-07 01:23:58'),
(6, 'Supervisor Comercial', 'supervisor_comercial', '2026-04-07 01:23:58'),
(7, 'Operaciones', 'operaciones', '2026-04-07 01:23:58'),
(8, 'Usuario de Empresa', 'usuario_empresa', '2026-04-07 01:23:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_permisos`
--

CREATE TABLE `roles_permisos` (
  `rol_id` bigint UNSIGNED NOT NULL,
  `permiso_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimientos_comerciales`
--

CREATE TABLE `seguimientos_comerciales` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `cotizacion_id` bigint UNSIGNED DEFAULT NULL,
  `cliente_id` bigint UNSIGNED DEFAULT NULL,
  `responsable` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `proxima_accion` varchar(220) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_seguimiento` date DEFAULT NULL,
  `comentarios` text COLLATE utf8mb4_unicode_ci,
  `estado_comercial` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'abierto',
  `probabilidad_cierre` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `seguimientos_comerciales`
--

INSERT INTO `seguimientos_comerciales` (`id`, `empresa_id`, `cotizacion_id`, `cliente_id`, `responsable`, `proxima_accion`, `fecha_seguimiento`, `comentarios`, `estado_comercial`, `probabilidad_cierre`, `fecha_creacion`) VALUES
(1, 69, 1, 3, 'Juan Perez', 'Llamar al cliente', '2026-04-09', 'Contactar para ver si necesita modificaciones en la cotización', 'en negociacion', 80, '2026-04-09 00:24:11'),
(2, 69, 2, 6, 'Juan Perez', 'Enviar una nueva cotización', '2026-04-09', 'Enviar cotización nueva con lo solicitado, para revisión y aprobación inmediata dentro de las próximas 48 horas', 'cerrado perdido', 100, '2026-04-09 00:26:00'),
(3, 69, 5, 4, 'Juan Perez', 'Llamar al cliente', '2026-04-09', 'Notificar al cliente el vencimiento de su cotización, darle opciones de renegociación', 'seguimiento programado', 45, '2026-04-09 00:33:49'),
(4, 73, 6, 8, 'sole', '', '2026-04-11', '', 'seguimiento programado', 0, '2026-04-11 11:12:40'),
(7, 69, 4, 6, 'Juan Perez', 'Llamar al cliente', '2026-04-12', '', 'en negociacion', 75, '2026-04-12 22:00:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `soporte_chats`
--

CREATE TABLE `soporte_chats` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `asunto` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` enum('abierto','cerrado') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'abierto',
  `no_leidos_admin` int UNSIGNED NOT NULL DEFAULT '0',
  `no_leidos_cliente` int UNSIGNED NOT NULL DEFAULT '0',
  `fecha_ultimo_mensaje` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `soporte_chats`
--

INSERT INTO `soporte_chats` (`id`, `empresa_id`, `asunto`, `estado`, `no_leidos_admin`, `no_leidos_cliente`, `fecha_ultimo_mensaje`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(6, 69, 'Ajuste en Lista de Precios Mayorista', 'abierto', 0, 0, '2026-04-12 23:11:12', '2026-04-12 23:07:42', '2026-04-14 22:34:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `soporte_chat_mensajes`
--

CREATE TABLE `soporte_chat_mensajes` (
  `id` bigint UNSIGNED NOT NULL,
  `chat_id` bigint UNSIGNED NOT NULL,
  `remitente_tipo` enum('cliente','admin') COLLATE utf8mb4_unicode_ci NOT NULL,
  `remitente_id` bigint UNSIGNED DEFAULT NULL,
  `mensaje` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `archivo_ruta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `archivo_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `archivo_tipo` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `archivo_peso` bigint UNSIGNED DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `soporte_chat_mensajes`
--

INSERT INTO `soporte_chat_mensajes` (`id`, `chat_id`, `remitente_tipo`, `remitente_id`, `mensaje`, `archivo_ruta`, `archivo_nombre`, `archivo_tipo`, `archivo_peso`, `fecha_creacion`) VALUES
(25, 6, 'cliente', 70, 'Necesito confirmar si es posible aplicar un descuento escalonado automáticamente (15% sobre 10 unidades y 20% sobre 50 unidades) en la misma lista \"Mayorista 2026\".', NULL, NULL, NULL, NULL, '2026-04-12 23:07:42'),
(26, 6, 'admin', 1, 'Hola buenas noches, aun no, pero lo implementamos en unos minutos', NULL, NULL, NULL, NULL, '2026-04-12 23:11:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suscripciones`
--

CREATE TABLE `suscripciones` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `plan_id` bigint UNSIGNED NOT NULL,
  `flow_subscription_id` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flow_plan_id` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('activa','pendiente','por_vencer','vencida','suspendida','cancelada') COLLATE utf8mb4_unicode_ci NOT NULL,
  `flow_estado` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entorno_flow` enum('sandbox','produccion') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `proxima_renovacion` datetime DEFAULT NULL,
  `fecha_cancelacion` datetime DEFAULT NULL,
  `renovacion_automatica` tinyint(1) NOT NULL DEFAULT '0',
  `tipo_cobro` enum('mensual','anual') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'mensual',
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `historial_eventos_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `suscripciones`
--

INSERT INTO `suscripciones` (`id`, `empresa_id`, `plan_id`, `flow_subscription_id`, `flow_plan_id`, `estado`, `flow_estado`, `entorno_flow`, `fecha_inicio`, `fecha_vencimiento`, `proxima_renovacion`, `fecha_cancelacion`, `renovacion_automatica`, `tipo_cobro`, `observaciones`, `historial_eventos_json`, `fecha_creacion`, `fecha_actualizacion`, `fecha_eliminacion`) VALUES
(49, 68, 1, NULL, NULL, 'activa', NULL, NULL, '2026-04-08', '2026-05-08', NULL, NULL, 1, 'mensual', 'Suscripción activada por pago aprobado en Flow.', NULL, '2026-04-08 03:38:50', '2026-04-08 03:40:37', '2026-04-12 00:32:36'),
(50, 69, 2, NULL, NULL, 'activa', NULL, NULL, '2026-04-08', '2026-05-08', NULL, NULL, 1, 'mensual', 'Cuenta suspendida temporalmente hasta validar pago Flow en /admin/flow/pagos. | Cambio de estado desde admin: activa', NULL, '2026-04-08 03:49:21', '2026-04-12 23:04:26', NULL),
(51, 70, 1, NULL, NULL, 'suspendida', NULL, NULL, '2026-04-10', '2027-04-10', NULL, NULL, 1, 'mensual', 'Cuenta suspendida: pago Flow no aprobado (rechazado).', NULL, '2026-04-10 02:06:27', '2026-04-10 02:08:17', '2026-04-12 00:32:26'),
(52, 71, 1, NULL, NULL, 'pendiente', NULL, NULL, '2026-04-11', '2026-04-26', NULL, NULL, 1, 'mensual', 'Alta inicial desde registro (mensual). Prueba gratis de 15 días antes del primer cobro.', NULL, '2026-04-11 02:06:29', NULL, '2026-04-11 02:15:05'),
(53, 72, 1, NULL, NULL, 'pendiente', NULL, NULL, '2026-04-11', '2026-04-26', NULL, NULL, 1, 'mensual', 'Alta inicial desde registro (mensual). Prueba gratis de 15 días antes del primer cobro.', NULL, '2026-04-11 02:15:09', NULL, '2026-04-12 02:06:45'),
(54, 73, 1, NULL, NULL, 'activa', NULL, NULL, '2026-04-11', '2026-04-26', NULL, NULL, 1, 'mensual', 'Cuenta suspendida temporalmente hasta validar pago Flow en /admin/flow/pagos. | Cambio de estado desde admin: activa', NULL, '2026-04-11 11:23:34', '2026-04-12 23:03:57', NULL),
(55, 74, 1, NULL, NULL, 'pendiente', NULL, NULL, '2026-04-11', '2026-04-26', NULL, NULL, 1, 'mensual', 'Alta inicial desde registro (mensual). Prueba gratis de 15 días antes del primer cobro.', NULL, '2026-04-11 18:32:29', NULL, '2026-04-12 03:49:16'),
(56, 75, 2, NULL, NULL, 'pendiente', NULL, NULL, '2026-04-11', '2026-04-26', NULL, NULL, 1, 'mensual', 'Alta inicial desde registro (mensual). Prueba gratis de 15 días antes del primer cobro.', NULL, '2026-04-11 21:29:32', NULL, '2026-04-12 02:35:36'),
(57, 77, 2, NULL, NULL, 'activa', NULL, NULL, '2026-04-14', '2027-12-16', NULL, NULL, 1, 'mensual', 'Alta inicial desde registro (mensual). Prueba gratis de 30 días antes del primer cobro. | Extensión admin: +335 días | Extensión admin: +9737 días', NULL, '2026-04-14 15:20:28', '2026-04-16 17:59:29', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED DEFAULT NULL,
  `rol_id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cargo` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biografia` text COLLATE utf8mb4_unicode_ci,
  `estado` enum('activo','inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `ultimo_acceso` datetime DEFAULT NULL,
  `password_actualizado_en` datetime DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `empresa_id`, `rol_id`, `nombre`, `correo`, `password`, `telefono`, `cargo`, `biografia`, `estado`, `ultimo_acceso`, `password_actualizado_en`, `fecha_creacion`, `fecha_actualizacion`, `fecha_eliminacion`) VALUES
(1, NULL, 1, 'Super Admin', 'superadmin@cotizapro.com', '$2y$12$l7d9QArsnPnqUeo/YjnXfOsDig87Wswc2LvMubdMw2kt1LRD4xhdi', NULL, NULL, NULL, 'activo', NULL, NULL, '2026-04-07 01:23:58', NULL, NULL),
(2, 1, 2, 'Administrador Principal', 'admin@cotizapro.com', '$2y$12$l7d9QArsnPnqUeo/YjnXfOsDig87Wswc2LvMubdMw2kt1LRD4xhdi', NULL, NULL, NULL, 'activo', NULL, NULL, '2026-04-07 01:23:58', NULL, NULL),
(69, 68, 2, 'Erwin Isla', 'erwin.2785@gmail.com', '$2y$10$z6qkdP/egVeVgSs03IJrxuN1KkX5rgy.5PQSpxBAIDfr1477A04Le', NULL, NULL, NULL, 'activo', NULL, NULL, '2026-04-08 03:38:50', NULL, '2026-04-12 00:32:36'),
(70, 69, 2, 'Juan Perez', 'vextracl@gmail.com', '$2y$10$RIItDWxvxRDsKTB148qU5ObfwIjpdZviy7FlL2Gh1T2QYVrV99oIy', NULL, NULL, NULL, 'activo', NULL, NULL, '2026-04-08 03:49:21', '2026-04-12 23:27:30', NULL),
(71, 70, 2, 'sole', 'pablitoislamella@gmail.com', '$2y$10$CPMfsBRjgzZdItoQEs0FU.eRUfrAoyThiHzW3q8G8xknpgjn4YwvC', NULL, NULL, NULL, 'activo', NULL, NULL, '2026-04-10 02:06:27', NULL, '2026-04-12 00:32:26'),
(72, 71, 2, 'Erwin Isla', 'contacto@gocreative.cl', '$2y$10$lFfyRKJTEJps2DNNq6SyMeAgCivwAAygD3G8M4nbav/2YYafTXCNC', NULL, NULL, NULL, 'activo', NULL, NULL, '2026-04-11 02:06:29', NULL, '2026-04-11 02:15:05'),
(73, 72, 2, 'Erwin Isla', 'eisla@fvolcan.cl', '$2y$10$.o5/fxg9cvbl5hsr/JqYoOKa.pgLAkmsVhGptwBF8Ny3g2UtHTXgW', NULL, NULL, NULL, 'activo', NULL, NULL, '2026-04-11 02:15:09', '2026-04-11 15:21:45', '2026-04-12 02:06:45'),
(74, 73, 2, 'sole', 'soledadmellazuniga@gmail.com', '$2y$10$FN/UDw4lvICZhmK7fMltxOzD5D9VQh6kbEG.a8rGLDo2MuvblbdJ.', '', '', '', 'activo', NULL, NULL, '2026-04-11 11:23:34', '2026-04-11 22:47:49', NULL),
(75, 74, 2, 'soledad', 'solcyta_240789@hotmail.com', '$2y$10$tSohGPskfBX1YTEunYKsKO0yM3Vm0DmkDWGbUK9j8/8HLwOP14dPq', NULL, NULL, NULL, 'activo', NULL, NULL, '2026-04-11 18:32:29', '2026-04-12 03:37:42', '2026-04-12 03:49:16'),
(76, 75, 2, 'SOLE M', 'vicente.isla13@gmail.com', '$2y$10$yIAetUvRN/XI4rGZ1HgPOeJ2MHuFQWyfxyp2ncp5FnPWks4X4mbOm', NULL, NULL, NULL, 'activo', NULL, NULL, '2026-04-11 21:29:32', '2026-04-11 22:46:48', '2026-04-12 02:35:36'),
(78, 77, 2, 'Vicente Isla M', 'visla@pvsport.cl', '$2y$10$Dd17X2ICLBPWjEct7CYkK.esTKEanmEYaNBtJ0exC8C1oTRDJ1lIC', NULL, NULL, NULL, 'activo', NULL, NULL, '2026-04-14 15:20:28', '2026-04-17 18:59:59', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedores`
--

CREATE TABLE `vendedores` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `usuario_id` bigint UNSIGNED DEFAULT NULL,
  `nombre` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comision` decimal(8,2) NOT NULL DEFAULT '0.00',
  `estado` enum('activo','inactivo') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'activo',
  `fecha_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vendedores`
--

INSERT INTO `vendedores` (`id`, `empresa_id`, `usuario_id`, `nombre`, `correo`, `telefono`, `comision`, `estado`, `fecha_creacion`) VALUES
(1, 69, NULL, 'Laura Garcia', 'lgarcia@empresastudio.cl', '987654321', 7.00, 'activo', '2026-04-08 15:43:19'),
(2, 69, NULL, 'Andres Soto', 'asoto@empresastudio.cl', '912345678', 3.00, 'activo', '2026-04-08 15:44:15'),
(3, 69, NULL, 'Carolina Mendez', 'cmendez@empresastudio.cl', '955443322', 0.00, 'activo', '2026-04-08 15:44:46'),
(4, 69, NULL, 'Roberto Muñoz', 'rmunoz@empresastudio.cl', '911223344', 5.00, 'activo', '2026-04-08 15:45:42'),
(5, 69, NULL, 'Jorge Cabezas', 'jcabezas@empresastudio.cl', '955664754', 3.00, 'inactivo', '2026-04-08 15:46:08'),
(6, 73, NULL, 'Juan', 'vendedordos@empresa.cl', '45122561313', 10.00, 'activo', '2026-04-11 11:05:05'),
(7, 73, 74, 'vendedor prueba cuatro', 'vendedor@pruebacuatro.cl', '45122561313', 10.00, 'activo', '2026-04-11 12:36:34'),
(8, 73, NULL, 'Vendedor Prueba Cinco', 'soledadmellazuniga@gmail.com', '965827533', 10.00, 'activo', '2026-04-11 13:34:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_pos`
--

CREATE TABLE `ventas_pos` (
  `id` bigint UNSIGNED NOT NULL,
  `empresa_id` bigint UNSIGNED NOT NULL,
  `caja_id` bigint UNSIGNED NOT NULL,
  `apertura_caja_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED DEFAULT NULL,
  `usuario_id` bigint UNSIGNED NOT NULL,
  `tipo_venta` enum('registrada','rapida') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'rapida',
  `subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `descuento` decimal(12,2) NOT NULL DEFAULT '0.00',
  `impuesto` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `estado` enum('pagada','anulada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pagada',
  `numero_venta` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_venta` datetime NOT NULL,
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `monto_recibido` decimal(12,2) NOT NULL DEFAULT '0.00',
  `vuelto` decimal(12,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ventas_pos`
--

INSERT INTO `ventas_pos` (`id`, `empresa_id`, `caja_id`, `apertura_caja_id`, `cliente_id`, `usuario_id`, `tipo_venta`, `subtotal`, `descuento`, `impuesto`, `total`, `estado`, `numero_venta`, `fecha_venta`, `observaciones`, `monto_recibido`, `vuelto`) VALUES
(1, 69, 1, 1, 1, 70, 'registrada', 980000.00, 147000.00, 158270.00, 991270.00, 'pagada', 'POS-069-00000001', '2026-04-08 15:52:55', '', 700000.00, 0.00),
(2, 69, 1, 1, 1, 70, 'registrada', 385000.00, 0.00, 73150.00, 458150.00, 'pagada', 'POS-069-00000002', '2026-04-08 15:55:44', '', 160000.00, 1850.00),
(3, 69, 1, 1, 1, 70, 'registrada', 65000.00, 0.00, 12350.00, 77350.00, 'pagada', 'POS-069-00000003', '2026-04-08 16:03:35', '', 0.00, 0.00),
(4, 69, 1, 1, 4, 70, 'registrada', 320000.00, 0.00, 60800.00, 380800.00, 'pagada', 'POS-069-00000004', '2026-04-09 01:43:44', '', 40000.00, 40000.00),
(5, 69, 1, 2, 5, 70, 'registrada', 250000.00, 10250.00, 45552.50, 285302.50, 'pagada', 'POS-069-00000005', '2026-04-09 21:31:00', '', 0.00, 0.00),
(6, 73, 2, 3, 7, 74, 'rapida', 9000.00, 0.00, 1710.00, 10710.00, 'pagada', 'POS-073-00000001', '2026-04-11 11:58:20', '', 8000.00, 7290.00),
(7, 73, 2, 3, 7, 74, 'rapida', 90000.00, 0.00, 17100.00, 107100.00, 'pagada', 'POS-073-00000002', '2026-04-11 13:29:49', '', 110000.00, 2900.00),
(8, 73, 2, 3, 7, 74, 'rapida', 27000.00, 0.00, 5130.00, 32130.00, 'pagada', 'POS-073-00000003', '2026-04-11 13:30:08', '', 0.00, 0.00),
(9, 73, 2, 3, 7, 74, 'rapida', 36000.00, 0.00, 6840.00, 42840.00, 'pagada', 'POS-073-00000004', '2026-04-11 13:30:33', '', 50000.00, 10000.00),
(10, 73, 2, 3, 7, 74, 'rapida', 24500.00, 0.00, 4655.00, 29155.00, 'pagada', 'POS-073-00000005', '2026-04-11 13:30:55', '', 0.00, 0.00),
(11, 73, 3, 4, 7, 74, 'rapida', 34059.00, 0.00, 6471.21, 40530.21, 'pagada', 'POS-073-00000006', '2026-04-11 14:32:09', '', 50000.00, 9469.79),
(12, 73, 4, 5, 10, 74, 'registrada', 36400.00, 0.00, 6916.00, 43316.00, 'pagada', 'POS-073-00000007', '2026-04-11 18:18:14', '', 45000.00, 1684.00),
(17, 69, 1, 2, 4, 70, 'registrada', 320000.00, 48000.00, 51680.00, 323680.00, 'pagada', 'POS-069-00000006', '2026-04-12 23:12:02', '', 300000.00, 0.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ajustes_inventario`
--
ALTER TABLE `ajustes_inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ajustes_empresa` (`empresa_id`,`fecha_creacion`),
  ADD KEY `fk_ajustes_producto` (`producto_id`),
  ADD KEY `fk_ajustes_usuario` (`usuario_id`);

--
-- Indices de la tabla `aperturas_caja_pos`
--
ALTER TABLE `aperturas_caja_pos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_aperturas_empresa_estado` (`empresa_id`,`estado`),
  ADD KEY `fk_aperturas_caja_pos` (`caja_id`),
  ADD KEY `fk_aperturas_usuario_pos` (`usuario_id`);

--
-- Indices de la tabla `aprobaciones_cotizacion`
--
ALTER TABLE `aprobaciones_cotizacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_aprobaciones_empresa` (`empresa_id`),
  ADD KEY `fk_aprobacion_cotizacion` (`cotizacion_id`);

--
-- Indices de la tabla `cajas_pos`
--
ALTER TABLE `cajas_pos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_caja_empresa_codigo` (`empresa_id`,`codigo`),
  ADD KEY `idx_cajas_pos_empresa` (`empresa_id`);

--
-- Indices de la tabla `catalogo_compras`
--
ALTER TABLE `catalogo_compras`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_catalogo_compras_flow_token` (`flow_token`),
  ADD KEY `idx_catalogo_compras_empresa` (`empresa_id`),
  ADD KEY `idx_catalogo_compras_estado_pago` (`estado_pago`);

--
-- Indices de la tabla `catalogo_compra_items`
--
ALTER TABLE `catalogo_compra_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_catalogo_compra_items_compra` (`compra_id`);

--
-- Indices de la tabla `categorias_productos`
--
ALTER TABLE `categorias_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_categorias_empresa` (`empresa_id`);

--
-- Indices de la tabla `cierres_caja_pos`
--
ALTER TABLE `cierres_caja_pos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cierres_empresa` (`empresa_id`),
  ADD KEY `fk_cierres_apertura_pos` (`apertura_caja_id`),
  ADD KEY `fk_cierres_usuario_pos` (`usuario_id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_clientes_empresa` (`empresa_id`),
  ADD KEY `fk_clientes_vendedor` (`vendedor_id`);

--
-- Indices de la tabla `clientes_listas_precios`
--
ALTER TABLE `clientes_listas_precios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_cliente_lista` (`empresa_id`,`cliente_id`,`lista_precio_id`),
  ADD KEY `idx_clientes_listas_lista` (`lista_precio_id`),
  ADD KEY `fk_clientes_listas_cliente` (`cliente_id`);

--
-- Indices de la tabla `configuraciones`
--
ALTER TABLE `configuraciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `configuraciones_empresa`
--
ALTER TABLE `configuraciones_empresa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_conf_empresa` (`empresa_id`,`clave`);

--
-- Indices de la tabla `configuracion_pos`
--
ALTER TABLE `configuracion_pos`
  ADD PRIMARY KEY (`empresa_id`);

--
-- Indices de la tabla `contactos_cliente`
--
ALTER TABLE `contactos_cliente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contactos_cliente` (`cliente_id`),
  ADD KEY `idx_contactos_empresa` (`empresa_id`);

--
-- Indices de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cot_num_empresa` (`empresa_id`,`numero`),
  ADD UNIQUE KEY `uq_cot_token_publico` (`token_publico`),
  ADD KEY `idx_cotizaciones_empresa` (`empresa_id`),
  ADD KEY `fk_cotizaciones_cliente` (`cliente_id`),
  ADD KEY `fk_cotizaciones_usuario` (`usuario_id`),
  ADD KEY `idx_cotizaciones_orden_origen` (`empresa_id`,`orden_compra_origen_id`);

--
-- Indices de la tabla `documentos_plantillas`
--
ALTER TABLE `documentos_plantillas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_documentos_empresa` (`empresa_id`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_empresas_plan_id` (`plan_id`);

--
-- Indices de la tabla `flow_clientes`
--
ALTER TABLE `flow_clientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_flow_cliente_empresa` (`empresa_id`),
  ADD UNIQUE KEY `uk_flow_customer_id` (`flow_customer_id`);

--
-- Indices de la tabla `flow_configuracion`
--
ALTER TABLE `flow_configuracion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_flow_config_entorno` (`entorno`);

--
-- Indices de la tabla `flow_configuraciones_empresa`
--
ALTER TABLE `flow_configuraciones_empresa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_flow_config_empresa` (`empresa_id`);

--
-- Indices de la tabla `flow_logs`
--
ALTER TABLE `flow_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_flow_logs_empresa` (`empresa_id`),
  ADD KEY `idx_flow_logs_tipo` (`tipo`),
  ADD KEY `fk_flow_logs_admin` (`admin_usuario_id`);

--
-- Indices de la tabla `flow_pagos`
--
ALTER TABLE `flow_pagos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_flow_pago_commerce` (`commerce_order`),
  ADD KEY `idx_flow_pago_empresa` (`empresa_id`),
  ADD KEY `fk_flow_pago_plan` (`plan_id`),
  ADD KEY `fk_flow_pago_suscripcion` (`suscripcion_id`),
  ADD KEY `fk_flow_pago_pago` (`pago_id`);

--
-- Indices de la tabla `flow_planes`
--
ALTER TABLE `flow_planes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_flow_plan_modalidad` (`plan_id`,`modalidad`),
  ADD UNIQUE KEY `uk_flow_plan_id` (`flow_plan_id`);

--
-- Indices de la tabla `flow_suscripciones`
--
ALTER TABLE `flow_suscripciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_flow_subscription_id` (`flow_subscription_id`),
  ADD KEY `idx_flow_sub_empresa` (`empresa_id`),
  ADD KEY `fk_flow_sub_plan` (`plan_id`),
  ADD KEY `fk_flow_sub_suscripcion` (`suscripcion_id`);

--
-- Indices de la tabla `flow_webhooks`
--
ALTER TABLE `flow_webhooks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_flow_webhook_hash` (`hash_unico`),
  ADD KEY `idx_flow_webhook_token` (`token`);

--
-- Indices de la tabla `funcionalidades`
--
ALTER TABLE `funcionalidades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo_interno` (`codigo_interno`);

--
-- Indices de la tabla `historial_actividad`
--
ALTER TABLE `historial_actividad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_historial_empresa` (`empresa_id`);

--
-- Indices de la tabla `historial_estados_cotizacion`
--
ALTER TABLE `historial_estados_cotizacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_historial_estado_cotizacion` (`cotizacion_id`),
  ADD KEY `fk_historial_estado_usuario` (`usuario_id`);

--
-- Indices de la tabla `historial_suscripciones`
--
ALTER TABLE `historial_suscripciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_historial_suscripcion` (`suscripcion_id`);

--
-- Indices de la tabla `items_cotizacion`
--
ALTER TABLE `items_cotizacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_items_cotizacion` (`cotizacion_id`),
  ADD KEY `fk_items_producto` (`producto_id`);

--
-- Indices de la tabla `items_venta_pos`
--
ALTER TABLE `items_venta_pos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_items_venta_pos_venta` (`venta_pos_id`),
  ADD KEY `fk_items_venta_pos_producto` (`producto_id`);

--
-- Indices de la tabla `listas_precios`
--
ALTER TABLE `listas_precios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_listas_empresa` (`empresa_id`);

--
-- Indices de la tabla `listas_precios_reglas`
--
ALTER TABLE `listas_precios_reglas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_lpr_empresa_lista` (`empresa_id`,`lista_precio_id`),
  ADD KEY `idx_lpr_producto` (`producto_id`),
  ADD KEY `idx_lpr_categoria` (`categoria_id`),
  ADD KEY `fk_lpr_lista` (`lista_precio_id`);

--
-- Indices de la tabla `logs_actividad`
--
ALTER TABLE `logs_actividad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_logs_empresa` (`empresa_id`),
  ADD KEY `fk_logs_usuario` (`usuario_id`);

--
-- Indices de la tabla `logs_administracion`
--
ALTER TABLE `logs_administracion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_logs_admin_usuario` (`admin_usuario_id`),
  ADD KEY `idx_logs_empresa` (`empresa_id`),
  ADD KEY `idx_logs_usuario_objetivo` (`usuario_objetivo_id`);

--
-- Indices de la tabla `logs_correos`
--
ALTER TABLE `logs_correos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `logs_pagos`
--
ALTER TABLE `logs_pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_logs_pagos_pago` (`pago_id`);

--
-- Indices de la tabla `movimientos_caja_pos`
--
ALTER TABLE `movimientos_caja_pos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_movimientos_caja_pos` (`empresa_id`,`fecha_movimiento`),
  ADD KEY `fk_mov_caja_pos` (`caja_id`),
  ADD KEY `fk_mov_apertura_pos` (`apertura_caja_id`),
  ADD KEY `fk_mov_usuario_pos` (`usuario_id`),
  ADD KEY `fk_mov_venta_pos` (`venta_pos_id`);

--
-- Indices de la tabla `movimientos_inventario`
--
ALTER TABLE `movimientos_inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_mov_empresa` (`empresa_id`,`fecha_creacion`),
  ADD KEY `idx_mov_producto` (`producto_id`,`fecha_creacion`),
  ADD KEY `fk_mov_usuario` (`usuario_id`);

--
-- Indices de la tabla `movimientos_inventario_pos`
--
ALTER TABLE `movimientos_inventario_pos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_mov_inv_pos_empresa` (`empresa_id`,`fecha_movimiento`),
  ADD KEY `fk_mov_inv_pos_venta` (`venta_pos_id`),
  ADD KEY `fk_mov_inv_pos_producto` (`producto_id`),
  ADD KEY `fk_mov_inv_pos_usuario` (`usuario_id`);

--
-- Indices de la tabla `notificaciones_empresa`
--
ALTER TABLE `notificaciones_empresa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_notificaciones_empresa` (`empresa_id`);

--
-- Indices de la tabla `ordenes_compra`
--
ALTER TABLE `ordenes_compra`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_orden_compra_empresa` (`empresa_id`,`fecha_creacion`),
  ADD KEY `fk_orden_compra_proveedor` (`proveedor_id`),
  ADD KEY `fk_orden_compra_usuario` (`usuario_id`),
  ADD KEY `idx_orden_compra_token_publico` (`token_publico`);

--
-- Indices de la tabla `ordenes_compra_detalle`
--
ALTER TABLE `ordenes_compra_detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_orden_compra_detalle` (`orden_compra_id`),
  ADD KEY `fk_orden_detalle_producto` (`producto_id`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pagos_empresa` (`empresa_id`),
  ADD KEY `fk_pagos_suscripcion` (`suscripcion_id`);

--
-- Indices de la tabla `pagos_venta_pos`
--
ALTER TABLE `pagos_venta_pos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pagos_venta_pos_venta` (`venta_pos_id`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- Indices de la tabla `planes`
--
ALTER TABLE `planes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indices de la tabla `plan_funcionalidades`
--
ALTER TABLE `plan_funcionalidades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_plan_funcionalidad` (`plan_id`,`funcionalidad_id`),
  ADD KEY `fk_pf_funcionalidad` (`funcionalidad_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_productos_empresa` (`empresa_id`),
  ADD KEY `fk_productos_categoria` (`categoria_id`);

--
-- Indices de la tabla `productos_imagenes`
--
ALTER TABLE `productos_imagenes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_productos_imagenes_producto` (`producto_id`),
  ADD KEY `idx_productos_imagenes_empresa` (`empresa_id`);

--
-- Indices de la tabla `proveedores_inventario`
--
ALTER TABLE `proveedores_inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_proveedores_empresa` (`empresa_id`);

--
-- Indices de la tabla `recepciones_inventario`
--
ALTER TABLE `recepciones_inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_recepciones_empresa` (`empresa_id`,`fecha_creacion`),
  ADD KEY `fk_recepciones_proveedor` (`proveedor_id`),
  ADD KEY `fk_recepciones_usuario` (`usuario_id`),
  ADD KEY `fk_recepciones_orden_compra` (`orden_compra_id`);

--
-- Indices de la tabla `recepciones_inventario_detalle`
--
ALTER TABLE `recepciones_inventario_detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_recepcion_detalle` (`recepcion_id`),
  ADD KEY `fk_recepcion_detalle_producto` (`producto_id`);

--
-- Indices de la tabla `restablecimientos_contrasena`
--
ALTER TABLE `restablecimientos_contrasena`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_restablecimientos_usuario` (`usuario_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- Indices de la tabla `roles_permisos`
--
ALTER TABLE `roles_permisos`
  ADD PRIMARY KEY (`rol_id`,`permiso_id`),
  ADD KEY `fk_rp_permiso` (`permiso_id`);

--
-- Indices de la tabla `seguimientos_comerciales`
--
ALTER TABLE `seguimientos_comerciales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_seguimiento_empresa` (`empresa_id`),
  ADD KEY `fk_seguimiento_cotizacion` (`cotizacion_id`),
  ADD KEY `fk_seguimiento_cliente` (`cliente_id`);

--
-- Indices de la tabla `soporte_chats`
--
ALTER TABLE `soporte_chats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_soporte_chats_empresa` (`empresa_id`),
  ADD KEY `idx_soporte_chats_no_leidos_admin` (`no_leidos_admin`);

--
-- Indices de la tabla `soporte_chat_mensajes`
--
ALTER TABLE `soporte_chat_mensajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_soporte_mensajes_chat` (`chat_id`);

--
-- Indices de la tabla `suscripciones`
--
ALTER TABLE `suscripciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_suscripciones_empresa` (`empresa_id`),
  ADD KEY `idx_suscripciones_estado` (`estado`),
  ADD KEY `fk_suscripciones_plan` (`plan_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `idx_usuarios_empresa` (`empresa_id`),
  ADD KEY `fk_usuarios_rol` (`rol_id`);

--
-- Indices de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_vendedores_empresa` (`empresa_id`),
  ADD KEY `idx_vendedores_usuario` (`usuario_id`);

--
-- Indices de la tabla `ventas_pos`
--
ALTER TABLE `ventas_pos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ventas_pos_numero_empresa` (`empresa_id`,`numero_venta`),
  ADD KEY `idx_ventas_pos_empresa_fecha` (`empresa_id`,`fecha_venta`),
  ADD KEY `fk_ventas_pos_caja` (`caja_id`),
  ADD KEY `fk_ventas_pos_apertura` (`apertura_caja_id`),
  ADD KEY `fk_ventas_pos_cliente` (`cliente_id`),
  ADD KEY `fk_ventas_pos_usuario` (`usuario_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ajustes_inventario`
--
ALTER TABLE `ajustes_inventario`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `aperturas_caja_pos`
--
ALTER TABLE `aperturas_caja_pos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `aprobaciones_cotizacion`
--
ALTER TABLE `aprobaciones_cotizacion`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `cajas_pos`
--
ALTER TABLE `cajas_pos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `catalogo_compras`
--
ALTER TABLE `catalogo_compras`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `catalogo_compra_items`
--
ALTER TABLE `catalogo_compra_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `categorias_productos`
--
ALTER TABLE `categorias_productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `cierres_caja_pos`
--
ALTER TABLE `cierres_caja_pos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `clientes_listas_precios`
--
ALTER TABLE `clientes_listas_precios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `configuraciones`
--
ALTER TABLE `configuraciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `configuraciones_empresa`
--
ALTER TABLE `configuraciones_empresa`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `contactos_cliente`
--
ALTER TABLE `contactos_cliente`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `documentos_plantillas`
--
ALTER TABLE `documentos_plantillas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT de la tabla `flow_clientes`
--
ALTER TABLE `flow_clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `flow_configuracion`
--
ALTER TABLE `flow_configuracion`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `flow_configuraciones_empresa`
--
ALTER TABLE `flow_configuraciones_empresa`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `flow_logs`
--
ALTER TABLE `flow_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `flow_pagos`
--
ALTER TABLE `flow_pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `flow_planes`
--
ALTER TABLE `flow_planes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `flow_suscripciones`
--
ALTER TABLE `flow_suscripciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `flow_webhooks`
--
ALTER TABLE `flow_webhooks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `funcionalidades`
--
ALTER TABLE `funcionalidades`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT de la tabla `historial_actividad`
--
ALTER TABLE `historial_actividad`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_estados_cotizacion`
--
ALTER TABLE `historial_estados_cotizacion`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `historial_suscripciones`
--
ALTER TABLE `historial_suscripciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `items_cotizacion`
--
ALTER TABLE `items_cotizacion`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT de la tabla `items_venta_pos`
--
ALTER TABLE `items_venta_pos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `listas_precios`
--
ALTER TABLE `listas_precios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `listas_precios_reglas`
--
ALTER TABLE `listas_precios_reglas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `logs_actividad`
--
ALTER TABLE `logs_actividad`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `logs_administracion`
--
ALTER TABLE `logs_administracion`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT de la tabla `logs_correos`
--
ALTER TABLE `logs_correos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `logs_pagos`
--
ALTER TABLE `logs_pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `movimientos_caja_pos`
--
ALTER TABLE `movimientos_caja_pos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `movimientos_inventario`
--
ALTER TABLE `movimientos_inventario`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `movimientos_inventario_pos`
--
ALTER TABLE `movimientos_inventario_pos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `notificaciones_empresa`
--
ALTER TABLE `notificaciones_empresa`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ordenes_compra`
--
ALTER TABLE `ordenes_compra`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `ordenes_compra_detalle`
--
ALTER TABLE `ordenes_compra_detalle`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos_venta_pos`
--
ALTER TABLE `pagos_venta_pos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `planes`
--
ALTER TABLE `planes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `plan_funcionalidades`
--
ALTER TABLE `plan_funcionalidades`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=500;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT de la tabla `productos_imagenes`
--
ALTER TABLE `productos_imagenes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT de la tabla `proveedores_inventario`
--
ALTER TABLE `proveedores_inventario`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `recepciones_inventario`
--
ALTER TABLE `recepciones_inventario`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `recepciones_inventario_detalle`
--
ALTER TABLE `recepciones_inventario_detalle`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `restablecimientos_contrasena`
--
ALTER TABLE `restablecimientos_contrasena`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `seguimientos_comerciales`
--
ALTER TABLE `seguimientos_comerciales`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `soporte_chats`
--
ALTER TABLE `soporte_chats`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `soporte_chat_mensajes`
--
ALTER TABLE `soporte_chat_mensajes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `suscripciones`
--
ALTER TABLE `suscripciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `ventas_pos`
--
ALTER TABLE `ventas_pos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ajustes_inventario`
--
ALTER TABLE `ajustes_inventario`
  ADD CONSTRAINT `fk_ajustes_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_ajustes_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `fk_ajustes_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `aperturas_caja_pos`
--
ALTER TABLE `aperturas_caja_pos`
  ADD CONSTRAINT `fk_aperturas_caja_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_aperturas_caja_pos` FOREIGN KEY (`caja_id`) REFERENCES `cajas_pos` (`id`),
  ADD CONSTRAINT `fk_aperturas_usuario_pos` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `aprobaciones_cotizacion`
--
ALTER TABLE `aprobaciones_cotizacion`
  ADD CONSTRAINT `fk_aprobacion_cotizacion` FOREIGN KEY (`cotizacion_id`) REFERENCES `cotizaciones` (`id`),
  ADD CONSTRAINT `fk_aprobacion_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `cajas_pos`
--
ALTER TABLE `cajas_pos`
  ADD CONSTRAINT `fk_cajas_pos_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `catalogo_compras`
--
ALTER TABLE `catalogo_compras`
  ADD CONSTRAINT `fk_catalogo_compras_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `catalogo_compra_items`
--
ALTER TABLE `catalogo_compra_items`
  ADD CONSTRAINT `fk_catalogo_compra_items_compra` FOREIGN KEY (`compra_id`) REFERENCES `catalogo_compras` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `categorias_productos`
--
ALTER TABLE `categorias_productos`
  ADD CONSTRAINT `fk_categorias_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `cierres_caja_pos`
--
ALTER TABLE `cierres_caja_pos`
  ADD CONSTRAINT `fk_cierres_apertura_pos` FOREIGN KEY (`apertura_caja_id`) REFERENCES `aperturas_caja_pos` (`id`),
  ADD CONSTRAINT `fk_cierres_empresa_pos` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_cierres_usuario_pos` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `fk_clientes_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_clientes_vendedor` FOREIGN KEY (`vendedor_id`) REFERENCES `vendedores` (`id`);

--
-- Filtros para la tabla `clientes_listas_precios`
--
ALTER TABLE `clientes_listas_precios`
  ADD CONSTRAINT `fk_clientes_listas_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `fk_clientes_listas_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_clientes_listas_lista` FOREIGN KEY (`lista_precio_id`) REFERENCES `listas_precios` (`id`);

--
-- Filtros para la tabla `configuraciones_empresa`
--
ALTER TABLE `configuraciones_empresa`
  ADD CONSTRAINT `fk_conf_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `configuracion_pos`
--
ALTER TABLE `configuracion_pos`
  ADD CONSTRAINT `fk_configuracion_pos_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `contactos_cliente`
--
ALTER TABLE `contactos_cliente`
  ADD CONSTRAINT `fk_contactos_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`);

--
-- Filtros para la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  ADD CONSTRAINT `fk_cotizaciones_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `fk_cotizaciones_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_cotizaciones_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `documentos_plantillas`
--
ALTER TABLE `documentos_plantillas`
  ADD CONSTRAINT `fk_documentos_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD CONSTRAINT `fk_empresas_plan` FOREIGN KEY (`plan_id`) REFERENCES `planes` (`id`);

--
-- Filtros para la tabla `flow_clientes`
--
DELETE fc
FROM `flow_clientes` fc
LEFT JOIN `empresas` e ON e.`id` = fc.`empresa_id`
WHERE e.`id` IS NULL;

ALTER TABLE `flow_clientes`
  ADD CONSTRAINT `fk_flow_cliente_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `flow_configuraciones_empresa`
--
ALTER TABLE `flow_configuraciones_empresa`
  ADD CONSTRAINT `fk_flow_config_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `flow_logs`
--
DELETE fl
FROM `flow_logs` fl
LEFT JOIN `empresas` e ON e.`id` = fl.`empresa_id`
LEFT JOIN `usuarios` u ON u.`id` = fl.`admin_usuario_id`
WHERE (fl.`empresa_id` IS NOT NULL AND e.`id` IS NULL)
   OR (fl.`admin_usuario_id` IS NOT NULL AND u.`id` IS NULL);

ALTER TABLE `flow_logs`
  ADD CONSTRAINT `fk_flow_logs_admin` FOREIGN KEY (`admin_usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `fk_flow_logs_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `flow_pagos`
--
ALTER TABLE `flow_pagos`
  ADD CONSTRAINT `fk_flow_pago_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_flow_pago_pago` FOREIGN KEY (`pago_id`) REFERENCES `pagos` (`id`),
  ADD CONSTRAINT `fk_flow_pago_plan` FOREIGN KEY (`plan_id`) REFERENCES `planes` (`id`),
  ADD CONSTRAINT `fk_flow_pago_suscripcion` FOREIGN KEY (`suscripcion_id`) REFERENCES `suscripciones` (`id`);

--
-- Filtros para la tabla `flow_planes`
--
ALTER TABLE `flow_planes`
  ADD CONSTRAINT `fk_flow_plan_plan` FOREIGN KEY (`plan_id`) REFERENCES `planes` (`id`);

--
-- Filtros para la tabla `flow_suscripciones`
--
ALTER TABLE `flow_suscripciones`
  ADD CONSTRAINT `fk_flow_sub_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_flow_sub_plan` FOREIGN KEY (`plan_id`) REFERENCES `planes` (`id`),
  ADD CONSTRAINT `fk_flow_sub_suscripcion` FOREIGN KEY (`suscripcion_id`) REFERENCES `suscripciones` (`id`);

--
-- Filtros para la tabla `historial_actividad`
--
ALTER TABLE `historial_actividad`
  ADD CONSTRAINT `fk_historial_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `historial_estados_cotizacion`
--
ALTER TABLE `historial_estados_cotizacion`
  ADD CONSTRAINT `fk_historial_estado_cotizacion` FOREIGN KEY (`cotizacion_id`) REFERENCES `cotizaciones` (`id`),
  ADD CONSTRAINT `fk_historial_estado_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `historial_suscripciones`
--
ALTER TABLE `historial_suscripciones`
  ADD CONSTRAINT `fk_historial_suscripcion` FOREIGN KEY (`suscripcion_id`) REFERENCES `suscripciones` (`id`);

--
-- Filtros para la tabla `items_cotizacion`
--
ALTER TABLE `items_cotizacion`
  ADD CONSTRAINT `fk_items_cotizacion` FOREIGN KEY (`cotizacion_id`) REFERENCES `cotizaciones` (`id`),
  ADD CONSTRAINT `fk_items_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `items_venta_pos`
--
ALTER TABLE `items_venta_pos`
  ADD CONSTRAINT `fk_items_venta_pos_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `fk_items_venta_pos_venta` FOREIGN KEY (`venta_pos_id`) REFERENCES `ventas_pos` (`id`);

--
-- Filtros para la tabla `listas_precios`
--
ALTER TABLE `listas_precios`
  ADD CONSTRAINT `fk_listas_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `listas_precios_reglas`
--
ALTER TABLE `listas_precios_reglas`
  ADD CONSTRAINT `fk_lpr_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categorias_productos` (`id`),
  ADD CONSTRAINT `fk_lpr_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_lpr_lista` FOREIGN KEY (`lista_precio_id`) REFERENCES `listas_precios` (`id`),
  ADD CONSTRAINT `fk_lpr_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `logs_actividad`
--
ALTER TABLE `logs_actividad`
  ADD CONSTRAINT `fk_logs_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_logs_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `logs_administracion`
--
DELETE la
FROM `logs_administracion` la
LEFT JOIN `empresas` e ON e.`id` = la.`empresa_id`
LEFT JOIN `usuarios` ua ON ua.`id` = la.`admin_usuario_id`
LEFT JOIN `usuarios` uo ON uo.`id` = la.`usuario_objetivo_id`
WHERE (la.`empresa_id` IS NOT NULL AND e.`id` IS NULL)
   OR (la.`admin_usuario_id` IS NOT NULL AND ua.`id` IS NULL)
   OR (la.`usuario_objetivo_id` IS NOT NULL AND uo.`id` IS NULL);

ALTER TABLE `logs_administracion`
  ADD CONSTRAINT `fk_logs_admin_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_logs_admin_usuario` FOREIGN KEY (`admin_usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `fk_logs_admin_usuario_obj` FOREIGN KEY (`usuario_objetivo_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `logs_pagos`
--
ALTER TABLE `logs_pagos`
  ADD CONSTRAINT `fk_logs_pagos_pago` FOREIGN KEY (`pago_id`) REFERENCES `pagos` (`id`);

--
-- Filtros para la tabla `movimientos_caja_pos`
--
ALTER TABLE `movimientos_caja_pos`
  ADD CONSTRAINT `fk_mov_apertura_pos` FOREIGN KEY (`apertura_caja_id`) REFERENCES `aperturas_caja_pos` (`id`),
  ADD CONSTRAINT `fk_mov_caja_empresa_pos` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_mov_caja_pos` FOREIGN KEY (`caja_id`) REFERENCES `cajas_pos` (`id`),
  ADD CONSTRAINT `fk_mov_usuario_pos` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `fk_mov_venta_pos` FOREIGN KEY (`venta_pos_id`) REFERENCES `ventas_pos` (`id`);

--
-- Filtros para la tabla `movimientos_inventario`
--
ALTER TABLE `movimientos_inventario`
  ADD CONSTRAINT `fk_mov_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_mov_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `fk_mov_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `movimientos_inventario_pos`
--
ALTER TABLE `movimientos_inventario_pos`
  ADD CONSTRAINT `fk_mov_inv_pos_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_mov_inv_pos_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `fk_mov_inv_pos_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `fk_mov_inv_pos_venta` FOREIGN KEY (`venta_pos_id`) REFERENCES `ventas_pos` (`id`);

--
-- Filtros para la tabla `notificaciones_empresa`
--
ALTER TABLE `notificaciones_empresa`
  ADD CONSTRAINT `fk_notificaciones_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `ordenes_compra`
--
ALTER TABLE `ordenes_compra`
  ADD CONSTRAINT `fk_orden_compra_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_orden_compra_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores_inventario` (`id`),
  ADD CONSTRAINT `fk_orden_compra_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `ordenes_compra_detalle`
--
ALTER TABLE `ordenes_compra_detalle`
  ADD CONSTRAINT `fk_orden_detalle_orden` FOREIGN KEY (`orden_compra_id`) REFERENCES `ordenes_compra` (`id`),
  ADD CONSTRAINT `fk_orden_detalle_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `fk_pagos_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_pagos_suscripcion` FOREIGN KEY (`suscripcion_id`) REFERENCES `suscripciones` (`id`);

--
-- Filtros para la tabla `pagos_venta_pos`
--
ALTER TABLE `pagos_venta_pos`
  ADD CONSTRAINT `fk_pagos_venta_pos_venta` FOREIGN KEY (`venta_pos_id`) REFERENCES `ventas_pos` (`id`);

--
-- Filtros para la tabla `plan_funcionalidades`
--
ALTER TABLE `plan_funcionalidades`
  ADD CONSTRAINT `fk_pf_funcionalidad` FOREIGN KEY (`funcionalidad_id`) REFERENCES `funcionalidades` (`id`),
  ADD CONSTRAINT `fk_pf_plan` FOREIGN KEY (`plan_id`) REFERENCES `planes` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_productos_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categorias_productos` (`id`),
  ADD CONSTRAINT `fk_productos_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `productos_imagenes`
--
ALTER TABLE `productos_imagenes`
  ADD CONSTRAINT `fk_productos_imagenes_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_productos_imagenes_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `proveedores_inventario`
--
ALTER TABLE `proveedores_inventario`
  ADD CONSTRAINT `fk_proveedores_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `recepciones_inventario`
--
ALTER TABLE `recepciones_inventario`
  ADD CONSTRAINT `fk_recepciones_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_recepciones_orden_compra` FOREIGN KEY (`orden_compra_id`) REFERENCES `ordenes_compra` (`id`),
  ADD CONSTRAINT `fk_recepciones_proveedor` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores_inventario` (`id`),
  ADD CONSTRAINT `fk_recepciones_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `recepciones_inventario_detalle`
--
ALTER TABLE `recepciones_inventario_detalle`
  ADD CONSTRAINT `fk_recepcion_detalle_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `fk_recepcion_detalle_recepcion` FOREIGN KEY (`recepcion_id`) REFERENCES `recepciones_inventario` (`id`);

--
-- Filtros para la tabla `restablecimientos_contrasena`
--
ALTER TABLE `restablecimientos_contrasena`
  ADD CONSTRAINT `fk_restablecimientos_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `roles_permisos`
--
ALTER TABLE `roles_permisos`
  ADD CONSTRAINT `fk_rp_permiso` FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`id`),
  ADD CONSTRAINT `fk_rp_rol` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `seguimientos_comerciales`
--
ALTER TABLE `seguimientos_comerciales`
  ADD CONSTRAINT `fk_seguimiento_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `fk_seguimiento_cotizacion` FOREIGN KEY (`cotizacion_id`) REFERENCES `cotizaciones` (`id`),
  ADD CONSTRAINT `fk_seguimiento_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `soporte_chats`
--
ALTER TABLE `soporte_chats`
  ADD CONSTRAINT `fk_soporte_chats_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `soporte_chat_mensajes`
--
ALTER TABLE `soporte_chat_mensajes`
  ADD CONSTRAINT `fk_soporte_mensajes_chat` FOREIGN KEY (`chat_id`) REFERENCES `soporte_chats` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `suscripciones`
--
ALTER TABLE `suscripciones`
  ADD CONSTRAINT `fk_suscripciones_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_suscripciones_plan` FOREIGN KEY (`plan_id`) REFERENCES `planes` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuarios_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_usuarios_rol` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `vendedores`
--
ALTER TABLE `vendedores`
  ADD CONSTRAINT `fk_vendedores_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_vendedores_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `ventas_pos`
--
ALTER TABLE `ventas_pos`
  ADD CONSTRAINT `fk_ventas_pos_apertura` FOREIGN KEY (`apertura_caja_id`) REFERENCES `aperturas_caja_pos` (`id`),
  ADD CONSTRAINT `fk_ventas_pos_caja` FOREIGN KEY (`caja_id`) REFERENCES `cajas_pos` (`id`),
  ADD CONSTRAINT `fk_ventas_pos_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `fk_ventas_pos_empresa` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_ventas_pos_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
