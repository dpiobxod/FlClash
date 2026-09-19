import 'package:flutter/material.dart';
import '../services/warp_generator.dart';

class WarpActionPage extends StatelessWidget {
  const WarpActionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QUCI Tactical WARP')),
      body: Center(
        child: ElevatedButton.styleFrom(
          // Кнопка запуска генерации каскада
        ).wrap(
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[800],
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              // Показываем индикатор загрузки
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Генерация WARP-in-WARP...')),
              );

              try {
                // Запускаем генерацию двух узлов
                final warpData = await WarpGenerator.generateWarpInWarp();
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Успешно сгенерировано! Outer/Inner готовы.')),
                );
                
                // Здесь полученные ключи (warpData['outer'] и warpData['inner']) 
                // передаются в конфигурацию ядра приложения
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ошибка: $e')),
                );
              }
            },
            child: const Text('Сгенерировать WARP-in-WARP'),
          ),
        ),
      ),
    );
  }
}

