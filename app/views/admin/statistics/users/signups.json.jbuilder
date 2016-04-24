json.labels @signups.map(&:date)
json.datasets [@signups] do |dataset|
    json.label "Регистрации"
    json.data dataset.map(&:signups)
end
