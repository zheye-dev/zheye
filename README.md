# zheye
Experimental Q&amp;A website based on RoR

## Important notification
Everyone should only push and pull to `dev` branch

`dev` would be merged to `master` when code are reviewed.

## Dev
Run
`bundle install` to install dependencies.

Run
`rake db:drop` and `rake db:migrate` to regenerate databases

Run
`rake rake sunspot:solr:start` to start a test searching engine

Run
`bundle exec rails server` to test

### Model

Read http://guides.ruby-china.org/active_record_basics.html and http://guides.ruby-china.org/association_basics.html first.

#### Question
```
belongs_to :user
has_many :answers
has_many :question_votes
has_many :question_comments
string :title
text :content
date :created_at
date :updated_at
```

#### Answer
```
belongs_to :user
belongs_to :question
has_many :answer_votes
has_many :answer_comments
text :content
date :created_at
date :updated_at
```

#### Comment(virtual)
```
belongs_to :user
text: content
date :created_at
date :updated_at
```

##### QuestionComment(inherits Comment)
```
belongs_to :question
```

##### AnswerComment(inherits Comment)
```
belongs_to :answer
```

#### Vote(virtual)
```
belongs_to :user
integer :attitude //up: +1, down: -1
date :created_at
date :updated_at
```

##### QuestionVote(inherits Vote)
```
belongs_to :question
```

##### AnswerVote(inherits Vote)
```
belongs_to :answer
```
