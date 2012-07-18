#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Company.destroy_all
TenderType.destroy_all
Tender.destroy_all
Category.destroy_all
OwnerForm.destroy_all
Sphere.roots.destroy_all

category = Category.create(name: 'Техника')
Category.create(name: 'Видео')
Category.create(name: 'Музыка')
Category.create(name: 'Информационные технологии')
Category.create(name: 'Бизнес')
Category.create(name: 'Книги')
Category.create(name: 'Услуги')
Category.create(name: 'Программы')

owner_form = OwnerForm.create(name: 'ООО', is_nds: 'true')
OwnerForm.create(name: 'ООО', is_nds: 'false')
OwnerForm.create(name: 'ОАО', is_nds: 'true')

s1 = Sphere.create(name: 'Информационные технологии')
s2 = Sphere.create(name: 'Бизнес')
s1.reload
s2.reload
s3 = Sphere.create(name: 'Веб-технологии', parent_id: s1.id)
Sphere.create(name: 'Продажа товаров', parent_id: s2.id)
s3.reload
Sphere.create(name: 'Создание сайтов', parent_id: s3.id)
Sphere.rebuild!
sphere = Sphere.last

company = Company.new(
	name:'Автолитмаш',
	general_phone:'111',
	inn:'4234234')

company.owner_form = owner_form
company.sphere = sphere
p 'компания создана успешно' if company.save

user = User.new(
	email:'admin@mlip.ru', 
	password:'111111',
	password_confirmation:'111111',
	name:'name',
	phone:'1',
	fname:'f',
	nname:'n')

user.categories << category
user.company = company
p 'пользователь создан успешно' if user.save

user.activate!

tender_type = TenderType.create(
	name:'tender',
	info:'Объявление тендера на продажу товара',
	is_iteration:false,
	is_selling:true)

TenderType.create(
	name:'tender',
	info:'Объявление итерационного тендера на продажу товара',
	is_iteration:true,
	is_selling:true)

TenderType.create(
	name:'auction',
	info:'Объявление аукциона на продажу товара',
	is_iteration:false,
	is_selling:true)

TenderType.create(
	name:'auction',
	info:'Объявление аукциона с фиксированным шагом на продажу товара',
	is_iteration:true,
	is_selling:true)

TenderType.create(
	name:'review',
	info:'Предварительный сбор предложений',
	is_iteration:false,
	is_selling:true)

TenderType.create(
	name:'tender',
	info:'Объявление тендера на покупку товара',
	is_iteration:false,
	is_selling:false)

TenderType.create(
	name:'tender',
	info:'Объявление итерационного тендера на покупку товара',
	is_iteration:true,
	is_selling:false)

TenderType.create(
	name:'auction',
	info:'Объявление аукциона на покупку товара',
	is_iteration:false,
	is_selling:false)

TenderType.create(
	name:'auction',
	info:'Объявление аукциона с фиксированным шагом на покупку товара',
	is_iteration:true,
	is_selling:false)

TenderType.create(
	name:'review',
	info:'Предварительный сбор предложений',
	is_iteration:false,
	is_selling:false)

p "Типы тендеров успешно созданы" if TenderType.all.size > 0
