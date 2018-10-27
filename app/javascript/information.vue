<template>
  <div>
    <div class="input-field">
      <select id="profile_grade" name="profile[grade]" v-model='selected_grade' @change="deleteDepartments">
        <option v-for="(value, key) in gradeLists" v-bind:value="value">{{key}}</option>
      </select>
      <label for="profile_grade">学年</label>
    </div>
    <div class="input-field">
      <select id="profile_school" name="profile[school]" v-model='selected_school' @change="fetchDepartments">
        <option v-for="(value, key) in schoolLists" v-bind:value="value">{{key}}</option>
      </select>
      <label for="profile_school">学院</label>
    </div>
    <div class="input-field" name="profile[department]" v-show='departmentBool'>
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
        data: function () {
            return {
                selected_grade: this.grade,
                selected_school: this.school,
                selected_department: this.department,
                message: "学年を入力してください",
                gradeLists: {"選択してください": "", "学部1年": "B1", "学部2年": "B2", "学部3年": "B3", "学部4年": "B4", "修士1年": "M1", "修士2年": "M2", "博士1年": "D1", "博士2年": "D2"},
                schoolLists: {"選択してください": "", "理学院": "理学院", "工学院": "工学院", "物質理工学院": "物質理工学院", "情報理工学院": "情報理工学院", "生命理工学院": "生命理工学院", "環境・社会理工学院": "環境・社会理工学院"},
                departmentBool: this.grade == 'B1' ? false : true,
                departmentLists: {"選択してください": "", "数学系": "数学系", "物理学系": "物理学系", "化学系": "化学系", "地球惑星科学系": "地球惑星科学系", "機械系": "機械系", "システム制御系": "システム制御系", "電気電子系": "電気電子系", "情報通信系": "情報通信系", "経営工学系": "経営工学系"
                                  , "材料系": "材料系", "応用科学系": "応用科学系", "数理・計算化学系": "数理・計算化学系", "情報工学系": "情報工学系", "生命理工学系": "生命理工学系"}
            }
        },
        methods: {
          deleteDepartments: function(){
            if(this.selected_grade == 'B1'){
              this.departmentBool = false
              this.selected_department = ''
            }
            else{
              this.departmentBool = true
            }
          },
          fetchDepartments: function(){
            var tmp_departmentLists = {};
            switch (this.selected_school){
              case '理学院':
              console.log('りこうがくいん');
                tmp_departmentLists = {"数学系": "数学系", "物理学系": "物理学系", "化学系": "化学系", "地球惑星科学系": "地球惑星科学系"}
                break;
              case '工学院':
                tmp_departmentLists = {"機械系": "機械系", "システム制御系": "システム制御系", "電気電子系": "電気電子系", "情報通信系": "情報通信系", "経営工学系": "経営工学系"}
                break;
              case '物質理工学院':
                tmp_departmentLists = {"材料系": "材料系", "応用科学系": "応用科学系"}
                break;
              case '情報理工学院':
                tmp_departmentLists = {"数理・計算化学系": "数理・計算化学系", "情報工学系": "情報工学系"}
                break;
              case '生命理工学院':
                tmp_departmentLists = {"生命理工学系": "生命理工学系"}
                break;
              case '環境・社会理工学院':
                tmp_departmentLists = {"建築学系": "建築学系", "土木・環境工学系": "土木・環境工学系", "融合理工系": "融合理工系", "社会・人間科学系": "社会・人間科学系", "イノベーション科学系": "イノベーション科学系", "技術経営専門職学位課程": "技術経営専門職学位課程"}
                break;
            }
            console.log(tmp_departmentLists);
            this.departmentLists = tmp_departmentLists;
            // this.$set(this.departmentLists, tmp_departmentLists);
            // this.departmentLists = Object.assign({}, this.departmentLists, tmp_departmentLists);
            console.log(this.departmentLists);
            // this.$forceUpdate();
          }
        }
    }
</script>

<style scoped>
</style>
