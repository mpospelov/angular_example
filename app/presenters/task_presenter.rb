class TaskPresenter < BasePresenter
  property :id
  property :description
  property :date, exec_context: :decorator
  property :duration

  def date
    represented.date.strftime("%D")
  end
end
