class Objective
  def locked?
    # Запрос
  end

  def release_lock
    # Команда
  end

  def release_lock!
    # Метис
  end
end

class Book
  def ebook?
    # Запрос
  end
 
  def path_prefix
    # Запрос
  end
 
  def file=(data)
    # Команда
  end
 
  def delete_file!
    # Метис
  end
 
  def file_url
    # Команда
  end
end