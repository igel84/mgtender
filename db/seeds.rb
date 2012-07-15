#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.destroy_all
Category.create(name: 'Техника')
Category.create(name: 'Видео')
Category.create(name: 'Музыка')
Category.create(name: 'Информационные технологии')
Category.create(name: 'Бизнес')
Category.create(name: 'Книги')
Category.create(name: 'Услуги')
Category.create(name: 'Программы')

Company.destroy_all
Company.create(name:'Автолитмаш')

OwnerForm.destroy_all
OwnerForm.create(name: 'ООО', is_nds: 'true')
OwnerForm.create(name: 'ООО', is_nds: 'false')
OwnerForm.create(name: 'ОАО', is_nds: 'true')

Sphere.destroy_all
s1 = Sphere.create(name: 'Информационные технологии')
s2 = Sphere.create(name: 'Бизнес')
s1.reload
s2.reload
s3 = Sphere.create(name: 'Веб-технологии', parent_id: s1.id)
Sphere.create(name: 'Продажа товаров', parent_id: s2.id)
s3.reload
Sphere.create(name: 'Создание сайтов', parent_id: s3.id)

Sphere.rebuild!