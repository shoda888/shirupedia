<template>
  <div>
    <div class="input-field">
      <select id="profile_grade" name="profile[grade]" v-model='selected_grade'>
        <option v-for="(value, key) in gradeLists" v-bind:value="value">{{key}}</option>
      </select>
      <label for="profile_grade">学年</label>
    </div>
    <div class="input-field">
      <select id="profile_school" name="profile[school]" v-model='selected_school'>
        <option v-for="(value, key) in schoolLists" v-bind:value="value">{{key}}</option>
      </select>
      <label for="profile_school">学院</label>
    </div>
    <div class="input-field">
      <select id="profile_department" name="profile[department]" v-model='selected_department'>
        <option v-for="(value, key) in departmentLists" v-bind:value="value">{{key}}</option>
      </select>
      <label for="profile_department">系</label>
    </div>
  </div>
</template>

<script>
    console.log('here is information')

    export default {
        props: ['grade', 'school', 'department'],
        methods: {
          setgradeInitial(){
            console.log(this.gradeLists);
            if(this.grade){
              return 'selected'
            }
            else{
              return ''
            }
          },
          setschoolInitial(){
            if(this.school){
              return 'selected'
            }
            else{
              return ''
            }
          },
          setdepartmentInitial(){
            if(this.department){
              return 'selected'
            }
            else{
              return ''
            }
          }
        },
        data: function () {
            return {
                selected_grade: this.grade,
                selected_school: this.school,
                selected_department: this.department,
                message: "学年を入力してください",
                gradeLists: {"選択してください": "", "学部1年": "B1", "学部2年": "B2", "学部3年": "B3", "学部4年": "B4", "修士1年": "M1", "修士2年": "M2", "博士1年": "D1", "博士2年": "D2"},
                schoolLists: {"選択してください": "", "理学院": "理学院", "工学院": "工学院", "物質理工学院": "物質理工学院", "情報理工学院": "情報理工学院",
                              "生命理工学院": "生命理工学院", "環境・社会理工学院": "環境・社会理工学院"},
                departmentLists: {"選択してください": "", "数学系": "数学系", "物理学系": "物理学系", "化学系": "化学系", "地球惑星科学系": "地球惑星科学系",
                                  "機械系": "機械系", "システム制御系": "システム制御系", "電気電子系": "電気電子系", "情報通信系": "情報通信系",
                                  "経営工学系": "経営工学系", "材料系": "材料系", "応用科学系": "応用科学系", "数理・計算化学系": "数理・計算化学系",
                                  "情報工学系": "情報工学系", "生命理工学系": "生命理工学系", "建築学系": "建築学系", "土木・環境工学系": "土木・環境工学系",
                                  "融合理工系": "融合理工系", "社会・人間科学系": "社会・人間科学系", "イノベーション科学系": "イノベーション科学系",
                                  "技術経営専門職学位課程": "技術経営専門職学位課程"}
            }
        }
    }
</script>

<style scoped>
</style>
