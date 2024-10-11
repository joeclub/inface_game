import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

import 'color_rect_component.dart';

class Countdown extends PositionComponent with HasGameRef {
  late TextComponent number;

  @override
  FutureOr<void> onLoad() async {
    priority = 9999;
    position = Vector2(640, 360);
    anchor = Anchor.center;
    ClipComponent backgroundClip = ClipComponent.circle(
      position: Vector2.zero(),
      anchor: Anchor.center,
      size: Vector2.all(100),
      scale: Vector2.all(1)
    );
    add(backgroundClip);
    ColorRectComponent background = ColorRectComponent(
      color: Colors.white,
      position: Vector2.zero(),
      size: Vector2(2560, 2560),
      //size: Vector2(1280, 720),
      anchor: Anchor.center,
    );
    backgroundClip.add(background);

    TextComponent readyText = TextComponent()
    ..anchor = Anchor.center
    ..text = 'READY'
    ..position = Vector2(0, 30)
    ..textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
    add(readyText);
 
    backgroundClip.add(
      ScaleEffect.to(
        Vector2.all(20),
        EffectController(duration: 0.5),
        onComplete: () async {
          await Future.delayed(const Duration(milliseconds: 3400));
          remove(readyText);
          //await Future.delayed(const Duration(milliseconds: 100));
          backgroundClip.add(
            ScaleEffect.to(
              Vector2.zero(),
              EffectController(duration: 0.5),
              onComplete: (){
              }
            )
          );
        }
      )
    );

    ClipComponent textClip = ClipComponent.rectangle(
      position: Vector2.zero(),
      anchor: Anchor.bottomCenter,
      size: Vector2(1280, 360),
    );

    add(textClip);

    PositionComponent numberParent = PositionComponent(
      anchor: Anchor.center,
      position: Vector2(textClip.size.x * 0.5, 360),
      angle: -tau / 2,
    );
    textClip.add(numberParent);

    number = TextComponent()
    ..anchor = Anchor.center
    ..text = '3'
    ..position = Vector2(0, -30)
    ..textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 50,
        color: Color.fromARGB(255, 23, 147, 236),
      ),
    );
    numberParent.add(number);
 
    numberParent.add(
      RotateEffect.to(0,
        EffectController(
          duration: 0.7,
          curve: Curves.easeInOutBack,
        ),
        onComplete: () {
          numberParent.add(
            RotateEffect.to(tau / 2,
              EffectController(
                duration: 0.7,
                curve: Curves.easeInOutBack,
              ),
              onComplete: (){
                numberParent.angle = -tau / 2;
                number.text = '2';
                numberParent.add(
                  RotateEffect.to(0,
                    EffectController(
                      duration: 0.7,
                      curve: Curves.easeInOutBack,
                    ),
                    onComplete: () {
                      numberParent.add(
                        RotateEffect.to(tau / 2,
                          EffectController(
                            duration: 0.7,
                            curve: Curves.easeInOutBack,
                          ),
                          onComplete: (){
                            numberParent.angle = -tau / 2;
                            number.text = '1';
                            numberParent.add(
                              RotateEffect.to(0,
                                EffectController(
                                  duration: 0.7,
                                  curve: Curves.easeInOutBack,
                                ),
                                onComplete: () {
                                  numberParent.add(
                                    RotateEffect.to(tau / 2,
                                      EffectController(
                                        duration: 0.7,
                                        curve: Curves.easeInOutBack,
                                      ),
                                      onComplete: (){
                                        
                                      }
                                    )
                                  );
                                }
                              )
                            );
                          }
                        )
                      );
                    }
                  )
                );
              }
            )
          );
        }
      )
    );
  }
}