module QuestionsHelper
  class DateSortStrategy
    def acquire_sorted
      Question.order('updated_at DESC').to_a
    end
  end

  class PrioritySortStrategy
    def acquire_sorted
      @questions = Question.all.to_a
      @questions.sort_by! do |question|
        - question.calculate_score
      end
    end
  end
end
