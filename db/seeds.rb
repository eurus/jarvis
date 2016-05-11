# sumary = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Optio odit, maxime iure? Reprehenderit tempora illo deleniti voluptatum totam eos architecto labore ea consequatur! Expedita, corporis recusandae iusto vitae minus facere, et quibusdam ad, voluptate fuga consectetur explicabo ut. Id officia consequatur consectetur deleniti totam neque ad dolore cupiditate reiciendis unde voluptate ratione illo cum itaque iusto dolores, tempora autem. Eligendi obcaecati rerum explicabo libero blanditiis pariatur delectus ex voluptate quis placeat dignissimos quaerat, facere maxime voluptates ad ducimus qui alias iste odio quod veniam. Quos excepturi deserunt iste reprehenderit. Facere laboriosam blanditiis optio voluptas assumenda odio fugiat perferendis, quas hic."
# hope = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quos ea cumque, perferendis quisquam molestiae suscipit error cupiditate eos, repellat vitae labore esse similique. Quasi rem quisquam, velit, ea obcaecati assumenda cupiditate, consequatur dolorem eveniet nihil nisi a! Distinctio, totam, veniam! Eum repellendus nihil quae excepturi quibusdam, laborum ducimus debitis totam obcaecati dolore dolor ab harum atque sequi architecto deserunt. Velit nemo atque, at amet doloremque ut et eligendi dicta ipsum ea alias numquam iusto fugiat facilis illo officia delectus ratione esse nisi, saepe aliquam. Consectetur possimus officiis, mollitia modi magnam laborum accusamus, illum voluptatum ad repellat eos odio aperiam ea."
# 30.times.each do |x|
#   Weekly.create(sumary: sumary, hope: hope)
# end

### 7.30 dump data

#Project.delete_all
require 'csv'

def fpp(pname)
  Project.find_by_name(pname).id
end
def fpo(email)
  User.find_by_email(email).id rescue 1
end
### run this first to import project records
# CSV.foreach('dump_data/project.csv', headers: true, col_sep: ',') do |row|
#   Project.create(
#     name: row["name"],
#     content: row["content"],
#     created_at: row["created_at"],
#     updated_at: row["updated_at"],
#     owner: (fpo row["owner"]),
#     status: 'done')
# end

### run this next to import vacation records
# Vacation.delete_all
# CSV.foreach('dump_data/vacation.csv', headers: true, col_sep: ',') do |row|
#   p = Vacation.new(
#     start_at: row["start_at"],
#     duration: row["duration"].to_f,
#     content: row["content"],
#     user_id: (fpo row["user"]),
#     approve: row["approve"],
#     cut: row["cut"])
#   p.save
#   ap p.errors
# end

### run this next to import errand records
Errand.delete_all
CSV.foreach('dump_data/errand.csv', headers: true, col_sep: ',') do |row|
  p = Errand.new(
    start_at: row["start_at"],
    end_at: row["end_at"],
    project_id: (fpp row["project"]),
    content: row["project"],
    user_id: (fpo row["user"]),
    approve: row["approve"],
    fee: row["fee"],
    issue: row["issue"],
    created_at: row["created_at"],
    updated_at: row["updated_at"]
  )
  p.save
  ap p.errors
end


### run this next to import overtime records
# Overtime.delete_all
# CSV.foreach('dump_data/overtime.csv', headers: true, col_sep: ',') do |row|
#   p = Overtime.new(
#     start_at: row["start_at"],
#     duration: row["duration"].to_f,
#     content: row["content"],
#     user_id: (fpo row["user"]),
#     approve: row["approve"],
#     issue: row["issue"],
#     created_at: row["created_at"],
#     updated_at: row["updated_at"]
#   )
#   p.save
#   ap p.errors
# end
