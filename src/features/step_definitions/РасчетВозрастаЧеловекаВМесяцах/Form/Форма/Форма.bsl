﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"УМеняЕстьДатаРожденияРавная(Парам01)","УМеняЕстьДатаРожденияРавная","Допустим  У меня есть дата рождения равная 01.01.1950","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"УМеняЕстьТекущаяДатаРавная(Парам01)","УМеняЕстьТекущаяДатаРавная","И У меня есть текущая дата равная 25.04.2017","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"РезультатВычисленияВозрастаБудетРавен(Парам01)","РезультатВычисленияВозрастаБудетРавен","Тогда Результат вычисления возраста будет равен 807","","");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//Допустим  У меня есть дата рождения равная 01.01.1950
//@УМеняЕстьДатаРожденияРавная(Парам01)
Процедура УМеняЕстьДатаРожденияРавная(ДатаРождения) Экспорт
	Контекст.Вставить("ДатаРождения", ДатаРождения);
КонецПроцедуры

&НаКлиенте
//И У меня есть текущая дата равная 25.04.2017
//@УМеняЕстьТекущаяДатаРавная(Парам01)
Процедура УМеняЕстьТекущаяДатаРавная(ТекущаяДата) Экспорт
	Контекст.Вставить("ТекущаяДата", ТекущаяДата);
КонецПроцедуры

&НаКлиенте
//Тогда Результат вычисления возраста будет равен 807
//@РезультатВычисленияВозрастаБудетРавен(Парам01)
Процедура РезультатВычисленияВозрастаБудетРавен(ОжидаемыйРезультат) Экспорт
	Результат = ОбщийМодуль1.ПолучитьРазницуДатВМесяцах(Контекст.ДатаРождения, Контекст.ТекущаяДата);
	Если НЕ Результат = ОжидаемыйРезультат Тогда
		ВызватьИсключение "Результат расчитан не верно";	
	КонецЕсли;
КонецПроцедуры
