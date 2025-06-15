<template>
	<div>
		<el-table :data="tableData" :height="tableHeight" :stripe="true" border :empty-text="dataText" v-loading="loading"
		 element-loading-text="拼命加载中" element-loading-spinner="el-icon-loading" element-loading-background="rgba(0, 0, 0, 0.06)">
			<el-table-column v-if="show" prop="id" align="center" label="id" min-width="6%"></el-table-column>
			<el-table-column prop="name" align="center" label="老师" min-width="7%"></el-table-column>
			<el-table-column align="center" label="应发工资" min-width="10%">
				<el-table-column prop="freeMoney" align="center" label="收费课程" sortable min-width="8%">
					<template slot-scope="scope">
						{{scope.row.freeMoney}}
					</template>
				</el-table-column>
				<el-table-column pro="chargeMoney" align="center" label="免费课程" sortable min-width="8%">
					<template slot-scope="scope">
						{{scope.row.chargeMoney}}
					</template>
				</el-table-column>
			</el-table-column>
			<el-table-column label="操作" align="center" min-width="12%">
				<template slot-scope="scope">
					<el-button size="small" type="primary" plain @click="
							dialogFormVisible = true;
							checkOut(scope.row, 0);
						">
						免费课程结算
					</el-button>
					<el-button size="small" type="primary" plain @click="
							dialogFormVisible = true;
							checkOut(scope.row, 1);
						">
						收费课程结算
					</el-button>
				</template>
			</el-table-column>
		</el-table>
		<el-dialog title="结账" :visible.sync="dialogFormVisible">
			<el-form :model="form" :rules="rules" ref="form">
				<el-form-item v-if="this.type == 0" label="结算工资" :label-width="formLabelWidth" class="widthControl" prop="freeMoney">
					<el-input v-model.number="form.freeMoney" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item v-if="this.type == 1" label="结算工资" :label-width="formLabelWidth" class="widthControl" prop="chargeMoney">
					<el-input v-model.number="form.chargeMoney" autocomplete="off"></el-input>
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button @click="dialogFormVisible = false">取 消</el-button>
				<el-button type="primary" @click="updateMoney()">确 定</el-button>
			</div>
		</el-dialog>
	</div>
</template>

<script>
	import axios from 'axios';
	export default {
		name: 'PersonalList',
		props: {
			tableData: Array,
			total: Number,
			dataText: String,
			loading: Boolean,
			toId: Number
		},
		data() {
			return {
				show: false,
				tableHeight: 500,
				dialogFormVisible: false,
				form: {},
				teachers: {},
				courses: {},
				formLabelWidth: '120px',
				rules: {
					freeMoney: [{
							required: true,
							message: '请输入结算金额',
							trigger: 'change'
						},
						{
							type: 'number',
							message: '请输入一个数字',
							trigger: 'change'
						},
					],
					chargeMoney: [{
							required: true,
							message: '请输入结算金额',
							trigger: 'change'
						},
						{
							type: 'number',
							message: '请输入一个数字',
							trigger: 'change'
						},
					]
				},
				type: 0
			};
		},
		methods: {
			myMessage(message, type) {
				this.$message({
					message: message,
					type: type
				});
			},
			checkOut(row, type) {
				this.form = row;
				this.type = type
			},
			updateMoney() {
				var formdata = new FormData();
				formdata.append("toId", this.toId);
				if (this.type == 0) {
					formdata.append("type", 0);
					formdata.append("toMoney", this.form.freeMoney);
				} else {
					formdata.append("type", 1);
					formdata.append("toMoney", this.form.chargeMoney);
				}
				formdata.append("tId", this.form.id);
				formdata.append("tMoney", 0);
				axios
					.post(this.$global_msg.adminRoute + '/teacher/updateTeacherMoney', formdata)
					.then(res => {
						this.dialogFormVisible = false;
						this.myMessage('结算成功', 'success');
						this.$emit('getTotelMoney');
						this.$emit('changePOrL', this.currPage, this.currLimit);
					})
					.catch(response => {
						this.myMessage('结算失败', 'error');
					});
			}
		}
	};
</script>

<style scoped="scoped">
	.avatar-uploader-icon {
		font-size: 28px;
		color: #8c939d;
		width: 178px;
		height: 178px;
		line-height: 178px;
		text-align: center;
		border: 1px #b5b5b5 dashed;
	}

	.avatar {
		width: 250px;
	}

	.widthControl {
		width: 80%;
	}
</style>
