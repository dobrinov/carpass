class UnfinishedRegistrationFacebookNotification < FacebookNotification
  private

  def message
    'Не си довършил регистрацията си в Carpass.bg. Направи това сега, като добавиш кола.'
  end
end
