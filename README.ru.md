:globe_with_meridians:  [english](README.md)    |   [český](README.cz.md)    |   **<u>русский</u>**

# Hello Dribbble

Этот  проект — демонстрация интерактивных анимаций, сделаных в качестве дебюта на **Dribbble**: [dribbble.com/tsinis](https://dribbble.com/tsinis)

![Steampunk Clock Visualisation](F:/Desktop/hello/hello_dribbble.gif)

Как вы можете видеть, анимация мяча реагирует на прикосновение/нажатуе + перетаскивание, так же как и заветный пригласительный билет Dribbble, который отображается в 3D. В основном это делается с помощью инструмента [Rive](https://rive.app) (бывшее Flare) в среде [Flutter](https://flutter.dev/). **Такой вид анимации может украсить ваши приложения для продажи билетов, банковских операций, карточных игр и т. д.** Эти анимации вы можете увидеть/форкнуть в моем профиле [Rive](https://rive.app/a/tsinis).

> **Заметка:** дизайн не зависит от платформы и размера экрана, потому что вся графика сделана в векторах (не растровых изображений) в Flutter, вы можете скачать бинарные файлы этого проекта для вашей платформы в [Releases](https://github.com/tsinis/hello_dribbble/releases) секции.

## Демонстрация во Flutter

Если вы предпочитаете запускать свои собственные сборки, вместо моих скомпилированных [релизов](https://github.com/tsinis/hello_dribbble/releases) - пожалуйста, выполните следующие команды в терминале:

````markdown
flutter upgrade
git clone https://github.com/tsinis/hello_dribbble.git
cd hello_dribbble
flutter run
````

## Лицензия и копирайты

Данное программное обеспечение выпускается под [лицензией MIT](https://github.com/tsinis/flro/blob/master/LICENSE).

## Шрифты

В этом дизайне используется 4 шрифта:

[Space Grotesk](https://fonts.floriankarsten.com/space-grotesk) (в текстах билетов),

[Slimlines](https://www.dafont.com/slimlines.font) (в слове HELLO),

[Ticketing](https://www.1001fonts.com/ticketing-font.html) (в текстах билетов),

и шрифт Flutter по умолчанию - [Roboto](https://fonts.google.com/specimen/Roboto) (для благодарственного текста).

Все эти шрифты являются OFL или бесплатны для личного использования. Вы можете найти файлы лицензий в [своих папках](./third-party/fonts).

## Заслуги

Все заслуги поступают на счёт команды [Rive](https://rive.app/), это действительно инструмент который меняет мир мобильных анимаций. Спасибо за семинар, которым я вдохновился ([Flare NYC Workshop and the Hamilton Design Challenge](https://medium.com/rive/flare-nyc-workshop-and-the-hamilton-design-challenge-ae8b2d1c73fc)) и особенно члену Rive Team - [@JcToon](https://github.com/JcToon) за его [баскетбольную анимацию](https://rive.app/a/JuanCarlos/files/flare/basketball-blur-effects/preview), который я форкнул. И конечно, все это было бы невозможно без [Flutter](https://github.com/flutter/flutter).