// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Не могу создать акт!
  internal static let actError = L10n.tr("Localizable", "act_error")
  /// Сохранить
  internal static let actSaveButtonTitle = L10n.tr("Localizable", "act_save_button_title")
  /// Акт
  internal static let actTitle = L10n.tr("Localizable", "act_title")
  /// Здесь будут показаны все товары, которые вы добавите в заявку
  internal static let addGoodsHint = L10n.tr("Localizable", "add_goods_hint")
  /// Добавить товары
  internal static let addGoodsTitle = L10n.tr("Localizable", "add_goods_title")
  /// Добавить в акт
  internal static let addToActTitle = L10n.tr("Localizable", "add_to_act_title")
  /// Авторизация
  internal static let authTitle = L10n.tr("Localizable", "auth_title")
  /// Назад
  internal static let backTitle = L10n.tr("Localizable", "back_title")
  /// Филиал
  internal static let branchTitle = L10n.tr("Localizable", "branch_title")
  /// Для сканирования приложению необходим доступ к камере.
  internal static let cameraDescriptionTitle = L10n.tr("Localizable", "camera_description_title")
  /// Камера
  internal static let cameraTitle = L10n.tr("Localizable", "camera_title")
  /// Отмена
  internal static let cancelTitle = L10n.tr("Localizable", "cancel_title")
  /// ОБРАБОТАННЫЕ
  internal static let completedTitle = L10n.tr("Localizable", "completed_title")
  /// Подвтердить
  internal static let confirmTitle = L10n.tr("Localizable", "confirm_title")
  /// Вы уверены, что хотите удалить товар из списка инвентаризации?
  internal static let deleteAlertDescription = L10n.tr("Localizable", "delete_alert_description")
  /// Удаление товара
  internal static let deleteAlertTitle = L10n.tr("Localizable", "delete_alert_title")
  /// Удалить %@
  internal static func deleteConfirmationTitle(_ p1: String) -> String {
    return L10n.tr("Localizable", "delete_confirmation_title", p1)
  }
  /// Удалить
  internal static let deleteTitle = L10n.tr("Localizable", "delete_title")
  /// Документы
  internal static let documentsTitle = L10n.tr("Localizable", "documents_title")
  /// Готово
  internal static let doneTitle = L10n.tr("Localizable", "done_title")
  /// Cрок реализации
  internal static let dueData = L10n.tr("Localizable", "due_data")
  /// Введите ваш адрес электронной почты и нажмите кнопку «Получить код»
  internal static let emailAuthDescription = L10n.tr("Localizable", "email_auth_description")
  /// ПО ЭЛЕКТРОННОЙ ПОЧТЕ
  internal static let emailAuthTitle = L10n.tr("Localizable", "email_auth_title")
  /// На ваш почтовый ящик было отправлено письмо с кодом подтверждения. Пожалуйста, введите его в поле ниже.
  internal static let emailConfirmDescription = L10n.tr("Localizable", "email_confirm_description")
  /// Адрес электронной почты
  internal static let emailPlaceholder = L10n.tr("Localizable", "email_placeholder")
  /// Дата окончания:
  internal static let endDateTitle = L10n.tr("Localizable", "end_date_title")
  /// Доступ в приложение запрещен!
  internal static let errorAccessAllowed = L10n.tr("Localizable", "error_access_allowed")
  /// Неверный формат.\nПроверьте Ваш email
  internal static let errorWrongEmail = L10n.tr("Localizable", "error_wrong_email")
  /// ПОЛУЧИТЬ КОД
  internal static let getCodeTitle = L10n.tr("Localizable", "get_code_title")
  /// ПОЛУЧИТЬ КОД
  internal static let getLinkTitle = L10n.tr("Localizable", "get_link_title")
  /// ТОВАРЫ
  internal static let goodsTitle = L10n.tr("Localizable", "goods_title")
  /// НЕ ОБРАБОТАННЫЕ
  internal static let incompleteTitle = L10n.tr("Localizable", "incomplete_title")
  /// ИНВ
  internal static let invButtonTitle = L10n.tr("Localizable", "inv_button_title")
  /// до %@ • %@
  internal static func inventoryInfoFormat(_ p1: String, _ p2: String) -> String {
    return L10n.tr("Localizable", "inventory_info_format", p1, p2)
  }
  /// Инвентаризация
  internal static let inventoryTitle = L10n.tr("Localizable", "inventory_title")
  /// Выберите юридическое лицо
  internal static let legalEntityPlaceholder = L10n.tr("Localizable", "legal_entity_placeholder")
  /// Юр. лицо
  internal static let legalEntityScreenTitle = L10n.tr("Localizable", "legal_entity_screen_title")
  /// Поиск юридического лица
  internal static let legalEntitySearchPlaceholder = L10n.tr("Localizable", "legal_entity_search_placeholder")
  /// ЮРИДИЧЕСКОЕ ЛИЦО
  internal static let legalEntityTitle = L10n.tr("Localizable", "legal_entity_title")
  /// ВОЙТИ
  internal static let logInTitle = L10n.tr("Localizable", "log_in_title")
  /// РУЧНОЙ ВВОД
  internal static let manualCodeTitle = L10n.tr("Localizable", "manual_code_title")
  /// минут
  internal static let minutesTitle = L10n.tr("Localizable", "minutes_title")
  /// Не получили код?
  internal static let notReceiveCodeTitle = L10n.tr("Localizable", "not_receive_code_title")
  /// Ок
  internal static let okButtonTitle = L10n.tr("Localizable", "ok_button_title")
  /// одна 
  internal static let oneUkFemale = L10n.tr("Localizable", "one_uk_female")
  /// один 
  internal static let oneUkMale = L10n.tr("Localizable", "one_uk_male")
  /// или
  internal static let orTitle = L10n.tr("Localizable", "or_title")
  /// Фильтр
  internal static let ordersFilterTitle = L10n.tr("Localizable", "orders_filter_title")
  /// Введите ваш номер телефона и нажмите кнопку «Получить код»
  internal static let phoneAuthDescription = L10n.tr("Localizable", "phone_auth_description")
  /// ПО НОМЕРУ ТЕЛЕФОНА
  internal static let phoneAuthTitle = L10n.tr("Localizable", "phone_auth_title")
  /// На Ваш номер телефона был отправлен код подтверждения. Пожалуйста, введите его ниже.
  internal static let phoneConfirmDescription = L10n.tr("Localizable", "phone_confirm_description")
  /// Для получения фотографии приложению необходим доступ к камере.
  internal static let photoDescription = L10n.tr("Localizable", "photo_description")
  /// Ценники
  internal static let pricetagTitle = L10n.tr("Localizable", "pricetag_title")
  /// Печать акта
  internal static let printActJobTitle = L10n.tr("Localizable", "print_act_job_title")
  /// Не могу выполнить печать!
  internal static let printError = L10n.tr("Localizable", "print_error")
  /// Название или штрихкод
  internal static let productSearchPlaceholder = L10n.tr("Localizable", "product_search_placeholder")
  /// Профиль
  internal static let profileTitle = L10n.tr("Localizable", "profile_title")
  /// Количество
  internal static let quantitiyLabel = L10n.tr("Localizable", "quantitiy_label")
  /// Отправить код еще раз
  internal static let resendCodeTitle = L10n.tr("Localizable", "resend_code_title")
  /// Разместите штрихкод в рамке чтобы отсканировать
  internal static let scannerHint = L10n.tr("Localizable", "scanner_hint")
  /// Сканирование
  internal static let scannerTitle = L10n.tr("Localizable", "scanner_title")
  /// Поиск филиала
  internal static let searchBranchPlaceholder = L10n.tr("Localizable", "search_branch_placeholder")
  /// Поиск
  internal static let searchPlaceholder = L10n.tr("Localizable", "search_placeholder")
  /// секунд
  internal static let secondsTitle = L10n.tr("Localizable", "seconds_title")
  /// Отправить в печать
  internal static let sendPrintTitle = L10n.tr("Localizable", "send_print_title")
  /// Настройки
  internal static let settingsButtonTitle = L10n.tr("Localizable", "settings_button_title")
  /// Дата начала:
  internal static let startDateTitle = L10n.tr("Localizable", "start_date_title")
  /// Прикрепите фото для завершения инвентаризации!
  internal static let successActMessage = L10n.tr("Localizable", "success_act_message")
  /// Акт сформирован
  internal static let successActTitle = L10n.tr("Localizable", "success_act_title")
  /// Вы можете отправить код еще раз через %@
  internal static func timerCodeMessage(_ p1: String) -> String {
    return L10n.tr("Localizable", "timer_code_message", p1)
  }
  /// Вы можете отправить email еще раз через %@
  internal static func timerEmailMessags(_ p1: String) -> String {
    return L10n.tr("Localizable", "timer_email_messags", p1)
  }
  /// дві 
  internal static let twoUkFemale = L10n.tr("Localizable", "two_uk_female")
  /// два 
  internal static let twoUkMale = L10n.tr("Localizable", "two_uk_male")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
