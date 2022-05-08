path = 'C:/Users/danma/RubymineProjects/untitled/drivers/chromedriver.exe'
include Selenium::WebDriver::Support
file = File.new('C:/Users/danma/RubymineProjects/untitled/Result.txt', 'a:UTF-8')

Given(/^Open browser$/) do
  @browser = Selenium::WebDriver.for :chrome, driver_path:path
  @browser.manage.timeouts.implicit_wait = 30

end

And(/^open site calcus\.ru$/) do
  url = 'https://calcus.ru/kalkulyator-ipoteki'
  @browser.navigate.to url

end

Then(/^Check elements$/) do
  @browser.manage.timeouts.implicit_wait = 10
  head1 = @browser.find_element(css: 'h1').enabled?
  head1_text = @browser.find_element(css: 'h1').text
  head1_expected_value = 'Ипотечный калькулятор'
  file.print("Тестирование ипотечного калькулятора на сайте calcus.ru\n")

  if head1_text == head1_expected_value and head1 == TRUE
    file.print("Элемент: заголовок 'Ипотечный калькулятор' доступен\n")
  else
    file.print("Элемент: заголовок 'Ипотечный калькулятор' не доступен\n")
  end

  #Проверка ссылок (по стоимости недвижимости и по сумме кредита)
  cost_of_property_method = @browser.find_element(css: ".calc-toggle.js-calc-toggle.current").enabled?
  cost_of_property_method_text = @browser.find_element(css: '.calc-toggle.js-calc-toggle.current').text
  cost_of_property_method_expected_value = 'По стоимости недвижимости'
  if cost_of_property_method_text == cost_of_property_method_expected_value and cost_of_property_method == TRUE
    file.print("Ссылка 'по стоимости недвижимости' доступна\n")
  else
    file.print("Ссылка 'по стоимости недвижимости' недоступна\n")
  end

  @browser.find_element(css: ".calc-toggle.js-calc-toggle.current").click #нажимаем на ссылку "по стоимости недвижимости"

  credit_sum_method = @browser.find_element(:link, "По сумме кредита").enabled?
  if credit_sum_method == TRUE
    file.print("Ссылка 'по сумме кредита' доступна\n")
  else
    file.print("Ссылка 'по сумме кредита' недоступны\n")
  end

  #Поля для заполнения данными:
  cost_of_property = @browser.find_element(:xpath, "//div[@class = 'calc-frow type-x type-1'][1]//div[@class='calc-fleft']").enabled?
  if cost_of_property == TRUE
    file.print("Элемент 'стоимость недвижимости' доступен\n")
  else
    file.print("Элемент 'стоимость недвижимости' недоступен\n")
  end

  first_pay = @browser.find_element(:xpath, "//div[@class = 'calc-frow type-x type-1'][2]//div[@class='calc-fleft']").enabled?
  if first_pay == TRUE
    file.print("Элемент 'первоначальный_взнос' доступен\n")
  else
    file.print("Элемент 'первоначальный_взнос' недоступен\n")
  end

  credit = @browser.find_element(:xpath, "//div[@class = 'calc-frow type-x type-1'][3]//div[@class='calc-fleft']").enabled?
  if credit == TRUE
    file.print("Элемент 'Сумма_кредита' доступен\n")
  else
    file.print("Элемент 'Сумма_кредита' недоступен\n")
  end

  credit_time = @browser.find_element(:xpath, "//div[@class = 'calc-frow calc_type-x calc_type-1 calc_type-3']//div[@class = 'calc-fleft']").enabled?
  if credit_time == TRUE
    file.print("Элемент 'Срок_кредита' доступен\n")
  else
    file.print("Элемент 'Срок_кредита' недоступен\n")
  end

  credit_percent = @browser.find_element(:xpath, "//div[@class = 'calc-frow']//div[@class = 'calc-fleft']").enabled?
  if credit_percent == TRUE
    file.print("Элемент 'Процентная_ставка' доступен\n")
  else
    file.print("Элемент 'Процентная_ставка' недоступен\n")
  end

  pay_type = @browser.find_element(:xpath, "//div[@class = 'calc-frow calc_type-x calc_type-1']//div[@class = 'calc-fleft']").enabled?
  if pay_type == TRUE
    file.print("Элемент 'Тип_ежемесячных_платежей' доступен\n")
  else
    file.print("Элемент 'Тип_ежемесячных_платежей' недоступен\n")
  end

end

Then(/^Check calculate$/) do
  cost_of_property = @browser.find_element(:xpath, "//div[@class = 'calc-frow type-x type-1']//div[@class = 'calc-fright']//div[@class = 'calc-input']//input[@name = 'cost']")
  cost_of_property.send_keys '12000000' #вставить в поле 12000000

  start_sum_type = @browser.find_elements(:xpath, "//div[@class ='calc-frow type-x type-1']//div[@class ='calc-input']//select[@name = 'start_sum_type']//option")
  start_sum_type.each { |a| a.click if (a.attribute("value")== '2')}

  start_sum_per = @browser.find_element(:xpath, "//div[@class ='calc-frow type-x type-1']//div[@class ='calc-input']//input[@name='start_sum']")
  start_sum_per.send_keys '20'



  #select_object = Select(start_sum_type)
  #select_object.select_by(:value, "2")

  credit_time = @browser.find_element(:xpath, "//div[@class ='calc-frow calc_type-x calc_type-1 calc_type-3']//div[@class ='calc-input']//input")
  credit_time.send_keys '20' #вставить в поле 20

  rnd = Random.new
  credit_percent_value = rnd.rand(5..12)

  credit_percent = @browser.find_element(:xpath, "//div[@class ='calc-frow']//div[@class ='calc-input']//input")
  credit_percent.send_keys credit_percent_value

  radio_button_ann = @browser.find_element(:xpath, "//div[@class ='calc-fright']//div[@class ='mb-2']//input").selected?
  radio_button_dif = @browser.find_element(:xpath, "//div[@class ='calc-fright']//input[@value= '2']").selected?

  if radio_button_dif == FALSE and radio_button_ann == TRUE
    calculate_button = @browser.find_element(:xpath, "//div[@class ='calc-frow button-row']//input")
    calculate_button.click
  elsif radio_button_ann == FALSE
    @browser.find_element(:xpath, "//div[@class ='calc-fright']//div[@class ='mb-2']//input").click
    calculate_button.click
  end
  sleep(5)
  file1 = File.new('C:/Users/danma/RubymineProjects/untitled/data.txt', 'a:UTF-8')
  file1.print("Указанные проценты #{credit_percent_value}\n")

  mothly_payment = @browser.find_element(:xpath, "//div[@class ='calc-result-value result-placeholder-monthlyPayment']").text
  #расчет ежемесячного платежа для проверки:
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

  file1.print("расчетное значение #{mothly_payment_exp}\n")
  file1.print("полученное значение #{mothly_payment}\n")

  if mothly_payment_exp == mothly_payment
    file.print("Расчет выполнен верно #{mothly_payment_exp}, #{mothly_payment}\n")
  else
    file.print("Расчет выполнен неверно #{mothly_payment_exp}, #{mothly_payment}\n")
  end

  file1.close
  file.close



end