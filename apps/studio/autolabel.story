MachineBoxClassificationBox create id:"gmail-labels"

when gmail inbox received as email
  res = MachineBoxClassificationBox predict id:"gmail-labels"
                                             inputs:email_to_inputs(email:email)
                                             limit:3
  if res.success
    redis sadd key:"tagged-by-ml" item:email.id

    labels = [] to List[int]
    foreach res.classes as cls
      if cls.score >= app.secrets.min_score
        labels = labels.append(item:cls.id)
    
    if labels.length() != 0
      email label add:labels

when gmail inbox labeled as email
  # skip if tagged by ML module
  if not (redis sismember key:"tagged-by-ml" item:email.id)

    inputs = email_to_inputs(:email)
    examples = [] to List[Map[string, any]]
    foreach email.labels as label
      examples = examples.append(item:{"class":label, "inputs":inputs})

    MachineBoxClassificationBox teach_multi id:"gmail-labels" :examples


function email_to_inputs email:object returns List[Map[string, string]]
  # structure data in a format the model requires to predict/teach
  return [
    {"key":"from",    "type":"keyword", "value":email.from},
    {"key":"to",      "type":"keyword", "value":email.to},
    {"key":"subject", "type":"string",  "value":email.subject},
    {"key":"body",    "type":"text",    "value":email.body}
  ]
