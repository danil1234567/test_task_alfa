#Определение шагов скрипта Test.feature
include Selenium::WebDriver::Support
path = 'C:/Users/danma/RubymineProjects/untitled/drivers/chromedriver.exe'

def check_element(selector, value, file)
  element = @browser.find_element(xpath: selector)
  element_enable = element.enabled?
  element_text =  element.text
  if element_enable == TRUE and element_text == value
    file.print("Элемент #{value} доступен\n")
  else
    file.print("Элемент #{value} не доступен\n")
  end
end

def calculate_monthly_pay(credit_percent_value)
  n = 240
  i = ((credit_percent_value.to_f)/12/100).to_f
  start_sum_per = 20
  cost_of_property = 12000000
  credit_sum = (100 - start_sum_per.to_f) / 100 * cost_of_property.to_f

  mothly_payment_exp = (credit_sum * (i * (1 + i)**n) / ( ( 1 + i )**n - 1)).to_f
  mothly_payment_exp.round(2).to_s.sub(".", ",")
end

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
  head1_slctr = "//div[@class = 'container-fluid' ]//h1" # Селектор элемента
  head1_expvalue = 'Ипотечный калькулятор' #ожидаемый текст
  check_element(head1_slctr, head1_expvalue, f_result)

  # Проверка ссылок (по стоимости недвижимости и по сумме кредита)
  # По стоимости недвижимости
  by_property_cost_slctr = "//div[@class = 'calc-fright' ]//a" # Селектор элемента
  by_property_cost_expvalue = 'По стоимости недвижимости' # ожидаемый текст
  check_element(by_property_cost_slctr, by_property_cost_expvalue, f_result)

  #По сумме кредита:
  credit_sum_slctr = "//div[@class = 'calc-fright' ]//a[2]" # Селектор элемента
  credit_sum_expvalue = "По сумме кредита"
  check_element(credit_sum_slctr, credit_sum_expvalue, f_result)

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

  # Проверка полей для заполнения данными
  # стоимость недвижимости:
  propety_cost_slctr = "//div[@class = 'calc-frow type-x type-1'][1]//div[@class='calc-fleft']" # Селектор элемента
  propety_cost_expvalue = "Стоимость недвижимости" # Ожидаемое значение
  check_element(propety_cost_slctr, propety_cost_expvalue, f_result)

  # Первоначальный взнос
  first_pay_slctr = "//div[@class = 'calc-frow type-x type-1'][2]//div[@class='calc-fleft']" # Селектор элемента
  first_pay_expvalue = "Первоначальный взнос" # Ожидаемое значение
  check_element(first_pay_slctr, first_pay_expvalue, f_result)

  # Сумма кредита
  credit_sclct = "//div[@class = 'calc-frow type-x type-1'][3]//div[@class='calc-fleft']" # Селектор элемента
  credit_expvalue = "Сумма кредита" # Ожидаемое значение
  check_element(credit_sclct, credit_expvalue, f_result)

  # Срок кредита
  credit_time_slct = "//div[@class = 'calc-frow calc_type-x calc_type-1 calc_type-3']//div[@class = 'calc-fleft']" # Селектор элемента
  credit_time_expvalue = "Срок кредита" # Ожидаемое значение
  check_element(credit_time_slct, credit_time_expvalue, f_result)

  # Срок кредита
  credit_percent_slct = "//div[@class = 'calc-frow']//div[@class = 'calc-fleft']" # Селектор элемента
  credit_percent_expvalue = "Процентная ставка" # Ожидаемое значение
  check_element(credit_percent_slct, credit_percent_expvalue, f_result)

  # Тип ежемесячных платежей
  pay_type_sclct = "//div[@class = 'calc-frow calc_type-x calc_type-1']//div[@class = 'calc-fleft']" # Селектор элемента
  pay_type_expvalue = "Тип ежемесячных платежей" # Ожидаемое значение
  check_element(pay_type_sclct, pay_type_expvalue, f_result)


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

  # Проверяем появление текста в разделах "Первоначальный взнос" и "Сумма кредита":
  start_sum_size = @browser.find_element(:xpath, "//div[@class = 'calc-input-desc start_sum_equiv']").text
  start_sum_size = start_sum_size.delete(')')
  start_sum_size = start_sum_size.delete('(')

  if start_sum_size == '2 400 000 руб.'
    f_result.print("Сумма первоначального взноса расчитана верно\n")
  else
    f_result.print("Сумма первоначального взноса расчитана неверно\n")
  end

  credit_sum_size = @browser.find_element(:xpath, "//span[@class = 'credit_sum_value text-muted']").text
  rub = @browser.find_element(:xpath, "//span[@class = 'calc-input-desc']").text
  credit_sum_size += ' ' + rub

  if credit_sum_size == '9 600 000 руб.'
    f_result.print("Сумма первоначального расчитана верно\n")
  else
    f_result.print("Сумма первоначального расчитана неверно\n")
  end

  #Установить срок кредита 20 лет
  credit_time = @browser.find_element(:xpath, "//div[@class ='calc-frow calc_type-x calc_type-1 calc_type-3']//div[@class ='calc-input']//input")
  credit_time.send_keys('20') #вставить в поле 20

  #Генерируем процентную ставку
  rnd = Random.new
  credit_percent_value = rnd.rand(5..12)

  #Заполняем поле с процентной ставкой сгенерированным значением
  credit_percent = @browser.find_element(:xpath, "//div[@class ='calc-frow']//div[@class ='calc-input']//input")
  credit_percent.send_keys credit_percent_value

  #Проверка отмечен радиобаттон "Аннуитетные" и расчет
  radio_button_ann = @browser.find_element(:xpath, "//div[@class ='calc-fright']//label[@for = 'payment-type-1']").selected?
  radio_button_dif = @browser.find_element(:xpath, "//div[@class ='calc-fright']//label[@for = 'payment-type-2']").selected?
  calculate_button = @browser.find_element(:xpath, "//div[@class ='calc-frow button-row']//input")

  calculate_button.click
  # if radio_button_dif == FALSE and radio_button_ann == TRUE
  #   @browser.find_element(:xpath, "//div[@class ='calc-fright']//label[@for = 'payment-type-2']").click
  #   calculate_button.click
  # elsif radio_button_ann == FALSE
  #   @browser.find_element(:xpath, "//div[@class ='calc-fright']//label[@for = 'payment-type-1']").click
  #   calculate_button.click
  # end

  f_result.print(radio_button_dif, radio_button_ann)
  # Ожидание загрузки страницы
  sleep(5)

  # Извлекаем полученное значение ежемесячного платежа
  mothly_payment = @browser.find_element(:xpath, "//div[@class ='calc-result-value result-placeholder-monthlyPayment']").text
  mothly_payment = mothly_payment.delete(' ')

  # Расчет ежемесячного платежа для проверки полученного значения и вывод результата:
  mothly_payment_exp = calculate_monthly_pay(credit_percent_value)

  if mothly_payment_exp == mothly_payment
    f_result.print("Расчет выполнен верно #{mothly_payment_exp}, #{mothly_payment}\n")
  else
    f_result.print("Расчет выполнен неверно #{mothly_payment_exp}, #{mothly_payment}\n")
  end

  f_result.close

end