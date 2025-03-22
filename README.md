# README

# Proje Adı
Lex ve Yacc ile Basit Hesap Makinesi

# Proje Amacı

Bu projede, Lex ve Yacc kullanarak basit bir hesap makinesi yorumlayıcısı (interpreter) geliştirilmiştir. Program, kullanıcıdan aritmetik ifadeler alarak bunları ayrıştırır (parse) ve sonuçlarını ekrana yazdırır. Ayrıca, ondalıklı (floating-point) sayı desteği ve üs alma (exponentiation) işlemlerini de içermektedir.

# Dosya Açıklamaları

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

# Özellikler

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

# Kurulum ve Çalıştırma

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


# TEST SENARYOLARI

<Basit Aritmetik İfadeler>

```Input:``` 3+5
```Output:``` 8

```Input:``` 10 * 4
```Output:``` 40

<Parantezli İfadeler>

```Input:``` (1+2) * 4
```Output:``` 32

```Input:``` (3-5) / 2
```Output:``` -1

<Daha Karmaşık İfadeler>

```Input:``` (3 + 5) * (2 - 1) / 4
```Output:``` 2

```Input:``` 1 + 2 * 3
```Output:``` 7

<Sıfıra Bölme Kontrolü>

```Input:``` 10 / 0
```Output:``` Division by zero error!

<Floating-Point (Ondalıklı) İfadeler>

```Input:``` 3.5 + 2.2
```Output:``` 5.7

```Input:``` 2.0 * 3.5
```Output:``` 7.0

<Us Alma (Exponentiation)>

```Input:``` 2 ^ 3
```Output:``` 8

```Input:``` 2 ^ 3 ^ 2
```Output:``` 512

```Input:``` (2 + 3) ^ 2
```Output:``` 25

<Geçersiz Karakter ve Diğer Hatalar>

```Input:``` 3 # 5
```Output:``` Unknown character

```Input:``` ((3 + 5)
```Output:``` Error: syntax error


