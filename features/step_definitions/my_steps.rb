#Определение шагов скрипта Test.feature

include Selenium::WebDriver::Support
path = 'C:/Users/danma/RubymineProjects/untitled/drivers/chromedriver.exe'
#открываем файл для записи результатов:
f_result = File.new('C:/Users/danma/RubymineProjects/untitled/Result.txt', 'w:UTF-8')

Given(/^Open browser$/) do
  @browser = Selenium::WebDriver.for :chrome, driver_path:path #создаем переменную экземпляра
  @browser.manage.timeouts.implicit_wait = 30 #устанавливаем неявное ожидание
end

And(/^open site calcus\.ru$/) do
  url = 'https://calcus.ru/kalkulyator-ipoteki' #url сайта для тестирования
  @browser.navigate.to url #переходим по ссылке
end

Then(/^Check elements$/) do

  f_result.print("Тестирование ипотечного калькулятора на сайте calcus.ru\n") #Начало тестирования

  #Проверка доступности элемента заголовок "Ипотечный калькулятор":
  head1 = @browser.find_element(xpath: "//div[@class = 'container-fluid' ]//h1").enabled? #инфо о доступности заголовка
  head1_text = @browser.find_element(xpath: "//div[@class = 'container-fluid' ]//h1").text #текст элемента
  head1_expvalue = 'Ипотечный калькулятор' #ожидаемый текст

  #Вывод результата:
  if head1 == TRUE and head1_expvalue == head1_text
    head1_result = "Элемент: заголовок 'Ипотечный калькулятор' доступен\n"
  else
    head1_result = "Элемент: заголовок 'Ипотечный калькулятор' не доступен\n"
  end
  f_result.print(head1_result)

  # Проверка ссылок (по стоимости недвижимости и по сумме кредита)
  # По стоимости недвижимости
  by_cost_of_property =\
  @browser.find_element(xpath: "//div[@class = 'calc-fright' ]//a").enabled? # инфо о доступности Элемента
  by_cost_of_property_text = @browser.find_element(xpath: "//div[@class = 'calc-fright' ]//a").text # текст элемента
  by_cost_of_property_expvalue = 'По стоимости недвижимости' # ожидаемый текст

  # Вывод результата:
  if by_cost_of_property_text == by_cost_of_property_expvalue and by_cost_of_property == TRUE
    by_cost_of_property_result = "Ссылка 'по стоимости недвижимости' доступна\n"
  else
    by_cost_of_property_result = "Ссылка 'по стоимости недвижимости' не доступна\n"
  end
  f_result.print(by_cost_of_property_result)

  #По сумме кредита:
  credit_sum = @browser.find_element(xpath: "//div[@class = 'calc-fright' ]//a[2]").enabled? #инфо о доступности Элемента
  credit_sum_text_expvalue = "По сумме кредита"
  credit_sum_text = @browser.find_element(xpath: "//div[@class = 'calc-fright' ]//a[2]").text #текст элемента

  #Trash
  # ========
  # a = @browser.find_elements(xpath: "//div[@class = 'calc-fright' ]//a")
  # for element in a
  #   if element.text == credit_sum_text_expvalue
  #     f_result.print(element.text)
  #     f_result.print("\n")
  #   end
  # end
  # =======

  #Вывод результата:
  if credit_sum == TRUE and credit_sum_text == credit_sum_text_expvalue
    credit_sum_result = "Ссылка 'по сумме кредита' доступна\n"
  else
    credit_sum_result = "Ссылка 'по сумме кредита' не доступна\n"
  end
  f_result.print(credit_sum_result)

  # Проверка полей для заполнения данными
  # стоимость недвижимости:
  cost_of_property = @browser.find_element(:xpath, "//div[@class = 'calc-frow type-x type-1'][1]//div[@class='calc-fleft']").enabled? #инфо о доступности Элемента
  cost_of_property_text = @browser.find_element(:xpath, "//div[@class = 'calc-frow type-x type-1'][1]//div[@class='calc-fleft']").text #текст элемента
  cost_of_property_expvalue = "Стоимость недвижимости" #Ожидаемое значение

  # Вывод результата:
  if cost_of_property == TRUE and cost_of_property_text == cost_of_property_expvalue
    cost_of_property_result = "Элемент 'стоимость недвижимости' доступен\n"
  else
    cost_of_property_result = "Элемент 'стоимость недвижимости' не доступен\n"
  end
  f_result.print(cost_of_property_result)

  # Первоначальный взнос
  first_pay = @browser.find_element(:xpath, "//div[@class = 'calc-frow type-x type-1'][2]//div[@class='calc-fleft']").enabled?
  if first_pay == TRUE
    f_result.print("Элемент 'первоначальный_взнос' доступен\n")
  else
    f_result.print("Элемент 'первоначальный_взнос' не доступен\n")
  end

  # Сумма кредита
  credit = @browser.find_element(:xpath, "//div[@class = 'calc-frow type-x type-1'][3]//div[@class='calc-fleft']").enabled?
  if credit == TRUE
    f_result.print("Элемент 'Сумма_кредита' доступен\n")
  else
    f_result.print("Элемент 'Сумма_кредита' недоступен\n")
  end

  # Срок кредита
  credit_time = @browser.find_element(:xpath, "//div[@class = 'calc-frow calc_type-x calc_type-1 calc_type-3']//div[@class = 'calc-fleft']").enabled?
  if credit_time == TRUE
    f_result.print("Элемент 'Срок_кредита' доступен\n")
  else
    f_result.print("Элемент 'Срок_кредита' недоступен\n")
  end

  # Процентная ставка
  credit_percent = @browser.find_element(:xpath, "//div[@class = 'calc-frow']//div[@class = 'calc-fleft']").enabled?
  if credit_percent == TRUE
    f_result.print("Элемент 'Процентная_ставка' доступен\n")
  else
    f_result.print("Элемент 'Процентная_ставка' недоступен\n")
  end

  # Тип ежемесячных платежей
  pay_type = @browser.find_element(:xpath, "//div[@class = 'calc-frow calc_type-x calc_type-1']//div[@class = 'calc-fleft']").enabled?
  if pay_type == TRUE
    f_result.print("Элемент 'Тип_ежемесячных_платежей' доступен\n")
  else
    f_result.print("Элемент 'Тип_ежемесячных_платежей' недоступен\n")
  end

end

Then(/^Check calculate$/) do

  # Заполнить поле стоимость недвижимости
  cost_of_property = @browser.find_element(:xpath, "//div[@class = 'calc-frow type-x type-1']//div[@class = 'calc-fright']//div[@class = 'calc-input']//input[@name = 'cost']")
  cost_of_property.send_keys '12000000' #вставить в поле 12000000

  #Выбрать из списка тип первоначального взноса: % от суммы
  start_sum_type = @browser.find_elements(:xpath, "//div[@class ='calc-frow type-x type-1']//div[@class ='calc-input']//select[@name = 'start_sum_type']//option")
  start_sum_type.each { |a| a.click if (a.attribute("value")== '2')}

  #Установить значение первоначального взноса в 20%
  start_sum_per = @browser.find_element(:xpath, "//div[@class ='calc-frow type-x type-1']//div[@class ='calc-input']//input[@name='start_sum']")
  start_sum_per.send_keys '20'

  # Todo: check_credit_sum and first_pay fields

  #Установить срок кредита 20 лет
  credit_time = @browser.find_element(:xpath, "//div[@class ='calc-frow calc_type-x calc_type-1 calc_type-3']//div[@class ='calc-input']//input")
  credit_time.send_keys '20' #вставить в поле 20

  #Генерируем процентную ставку
  rnd = Random.new
  credit_percent_value = rnd.rand(5..12)

  #Заполняем поле с процентной ставкой сгенерированным значением
  credit_percent = @browser.find_element(:xpath, "//div[@class ='calc-frow']//div[@class ='calc-input']//input")
  credit_percent.send_keys credit_percent_value

  #Проверка отмечен радиобаттон "Аннуитетные" и расчет
  radio_button_ann = @browser.find_element(:xpath, "//div[@class ='calc-fright']//div[@class ='mb-2']//input").selected?
  radio_button_dif = @browser.find_element(:xpath, "//div[@class ='calc-fright']//input[@value= '2']").selected?
  calculate_button = @browser.find_element(:xpath, "//div[@class ='calc-frow button-row']//input")

  if radio_button_dif == FALSE and radio_button_ann == TRUE
    calculate_button.click
  elsif radio_button_ann == FALSE
    @browser.find_element(:xpath, "//div[@class ='calc-fright']//div[@class ='mb-2']//input").click
    calculate_button.click
  end

  # ожидание загрузки страницы
  sleep(5)

  # Извлекаем полученное значение ежемесячного платежа
  mothly_payment = @browser.find_element(:xpath, "//div[@class ='calc-result-value result-placeholder-monthlyPayment']").text

  #расчет ежемесячного платежа для проверки полученного значения:
  n = 240
  i = ((credit_percent_value.to_f)/12/100).to_f
  start_sum_per = 20
  cost_of_property = 12000000
  credit_sum = (100 - start_sum_per.to_f) / 100 * cost_of_property.to_f

  mothly_payment_exp = (credit_sum * (i * (1 + i)**n) / ( ( 1 + i )**n - 1)).to_f
  mothly_payment_exp = mothly_payment_exp.round(2)

  mothly_payment = mothly_payment.delete(' ')
  mothly_payment_exp = mothly_payment_exp.to_s
  mothly_payment_exp = mothly_payment_exp.sub(".", ",")

  # вывод результата
  if mothly_payment_exp == mothly_payment
    f_result.print("Расчет выполнен верно #{mothly_payment_exp}, #{mothly_payment}\n")
  else
    f_result.print("Расчет выполнен неверно #{mothly_payment_exp}, #{mothly_payment}\n")
  end

  f_result.close

end