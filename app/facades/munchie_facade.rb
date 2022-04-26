class MunchieFacade
  def self.get_munchies(location, food)
    MunchieService.get_munchies_at(location, food)
  end
end
