# README

### BIL 395 Ödev 1
### Adı Soyadı:
Hayrettin Kaan Özsoy
### Öğrenci Numarası:
201104086

## Proje Adı
Lex ve Yacc ile Basit Hesap Makinesi

## Proje Amacı

Bu projede, Lex ve Yacc kullanarak basit bir hesap makinesi yorumlayıcısı (interpreter) geliştirilmiştir. Program, kullanıcıdan aritmetik ifadeler alarak bunları ayrıştırır (parse) ve sonuçlarını ekrana yazdırır. Ayrıca, ondalıklı (floating-point) sayı desteği ve üs alma (exponentiation) işlemlerini de içermektedir.

## Dosya Açıklamaları

```calculator.l:```
- Lex (Flex) tanımlamalarını içerir.
- Aritmetik operatörleri (+, -, *, /, ^), parantezleri, ondalıklı/tam sayıları tanır ve bunları ilgili token’lara dönüştürür.
- Boşluk ve tab karakterlerini yoksayar.
- Newline \n karakterini, satır sonunu yakalamak amacıyla parser’a gönderir.
- Tanımsız karakterlere dair uyarı mesajı verir.

```calculator.y:```
- Yacc (Bison) tanımlamalarını içerir.
- Token’ların gramer kurallarına göre birleştirilmesini (parse) sağlar.
- Aritmetik işlemler (toplama, çıkarma, çarpma, bölme, üs alma), parantezler, ve sayıların yorumlanması için kuralları tanımlar.
- Sıfıra bölme ve diğer hataları yönetir.

- Örnek: ```expr -> expr PLUS expr``` ile toplama işlemi tanımlanmıştır.

## Özellikler

1. Tam sayılar ve ondalıklı sayılar (floating-point) desteklenir.

2. Aritmetik Operatörler: +, -, *, / ve üs alma (^).

3. Parantezler: ( ve ) ile ifadeleri gruplayabilirsiniz.

4. Operatör Önceliği ve Bağlayıcılık:

    - ^ (üs alma) sağdan bağlayıcı (%right).

    - * ve / operatörleri, + ve -’tan daha yüksek önceliğe sahiptir.

    - + ve - en düşük önceliğe sahiptir.

5. Hata Yönetimi:

    - Geçersiz karakter girildiğinde ekrana uyarı mesajı basar.

    - Sıfıra bölme durumunda hata mesajı gösterir ve programdan çıkar.

    - Söz dizimi hatası (syntax error) durumunda bir uyarı verir.

## Kurulum ve Çalıştırma

1. Gerekli Bağımlılıklar:
    - Linux/Unix ortamında Flex, Bison ve GCC yüklü olmalıdır.
    - Örnek kurulum (Ubuntu/Debian):
    
      ```sudo apt-get install flex bison gcc```

2. Derleme Adımları:
    - <Lex dosyasını derle:
      ```flex calculator.l```

      Bu komut <lex.yy.c> adlı dosyayı oluşturur.

    - <Yacc dosyasını derle:
      ```yacc -d calculator.y```
    
      Bu komut <y.tab.c> ve <y.tab.h> dosyalarını oluşturur.

    - <Tümünü GCC ile derle:
      ```gcc lex.yy.c y.tab.c -o calculator -lm```

      Burada ```-lm``` parametresi, pow fonksiyonu için matematik kütüphanesini linkler.

3. Programı Çalıştırma:
    ```./calculator```

    Komut satırında **“Input”** mesajı çıktıktan sonra aritmetik ifadeyi girebilirsiniz. Enter’a basıldığında sonuç ekranda görüntülenir.


## TEST SENARYOLARI

<Basit Aritmetik İfadeler>

```Input:``` 7+9
```Output:``` 16

```Input:``` 12 - 5
```Output:``` 7

```Input:``` 6 * 8
```Output:``` 48

```Input:``` 24 / 6
```Output:``` 4

<Parantezli İfadeler>

```Input:``` (2 + 4) * 3
```Output:``` 18

```Input:``` (10-8) / 2
```Output:``` 1

<Daha Karmaşık İfadeler>

```Input:``` (2 + 2) * (5 - 1) / 2
```Output:``` 8

```Input:``` 3 + 4 * 2 - (1 / (2 + 1))
```Output:``` 10.6667

<Sıfıra Bölme Kontrolü>

```Input:``` 15 / 0
```Output:``` Division by zero error!

<Floating-Point (Ondalıklı) İfadeler>

```Input:``` 4.2 + 1.3
```Output:``` 5.5

```Input:``` 10.0 / 2.5
```Output:``` 4.0

<Us Alma (Exponentiation)>

```Input:``` 3 ^ 4
```Output:``` 81

```Input:``` 2 ^ 3 ^ 2
```Output:``` 512

```Input:``` (1 + 2) ^ 3
```Output:``` 27

<Geçersiz Karakter ve Diğer Hatalar>

```Input:``` 4 $ 2
```Output:``` Unknown character

```Input:``` ((4 + 5)
```Output:``` Error: syntax error


