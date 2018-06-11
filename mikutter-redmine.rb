Plugin.create(:"mikutter-redmine") do
  re = %r/🎫([0-9]*)/

  filter_score_filter do |model, note, yielder|
    if model != note
      m = re.match(note.description)
      if m
        score = []
        score << Diva::Model(:score_text).new(description: m.pre_match)
        score << Diva::Model(:score_hyperlink).new(description: m[0], uri: "https://dev.mikutter.hachune.net/issues/#{m[1]}")
        score << Diva::Model(:score_text).new(description: m.post_match)
        yielder << score
      end
    end
    [model, note, yielder]
  end
end
